class Contact < ActiveRecord::Base
  has_uuid
  has_search_type

  scope :mine		, lambda { |user_id| where(:user_id => user_id) }

  validates :email	, :presence => true, :length => { :maximum => 255 }

  belongs_to :identity
  belongs_to :user
  scope :by_user, lambda { |user_id| where("users.id = ?", user_id ) }

  searchable do
    string  :search_type, :stored => true
    text    :email,       :stored => true 
    integer :user_id,     :references => User
    integer :identity_id, :references => Identity
    time    :created_at,  :trie => true
  end

  def self.google_import(user)
    new_contacts = Array.new
    existing_contacts = user.contacts
    imported_contacts = user.google.portable_contacts.all

    for import in imported_contacts
      next if import.email.nil?
      next if (import.email.include? "subscribe" ) || (import.email.include? "googlegroups.com")
      next if existing_contacts.collect{|x| x.email}.include?(import.email.downcase)
      new_contacts << import_contact(user, import.display_name, import.email.downcase, 1)
    end
    new_contacts
  end

  def self.yahoo_import(user)
    new_contacts = Array.new
    existing_contacts = user.contacts
    imported_contacts = user.yahoo.social_api.contacts

    for import in imported_contacts["contacts"]["contact"]
      name = ""

      for field in import["fields"]
        if field["type"] == "name"
          name = name + field["value"]["givenName"] unless field["value"]["givenName"].nil?
          name = name + " " + field["value"]["middleName"] unless field["value"]["middleName"].nil?
          name = name + " " + field["value"]["familyName"] unless field["value"]["familyName"].nil?
        end
        email = field["value"].to_s.downcase if (field["type"] == "yahooid") || (field["type"] == "email")
      end

      #skip empty, groups or subscription and existing e-mail addresses
      next if email.nil?
      next if (email.include? "subscribe" ) || (email.include? "googlegroups.com")
      next if existing_contacts.collect{|x| x.email}.include?(email)

      new_contacts << import_contact(user, name, email, 1)
    end
    new_contacts
  end

  def self.live_import(user, request_parameters)
    new_contacts = Array.new
    existing_contacts = user.contacts

    wl = WindowsLive.new
    imported_contacts = wl.contacts(request_parameters)

    for import in imported_contacts
      #skip empty, groups or subscription and existing e-mail addresses
      next if import["email"].nil?
      next if (import["email"].include? "subscribe" ) || (import["email"].include? "googlegroups.com")
      next if existing_contacts.collect{|x| x.email}.include?(import["email"].to_s.downcase)

      new_contacts << import_contact(user, import["name"], import["email"].to_s.downcase, 1)
    end
    new_contacts
  end


  def self.twitter_import(user)
    new_contacts = Array.new
    existing_contacts = user.contacts.joins(:identity).where(:identities => {:provider_id => 2})
    credentials = Identity.where(:user_id => user.id, :provider_id => 2).first

    client = Twitter::Client.new(:consumer_key => TWITTER_ID, :consumer_secret => TWITTER_SECRET, :oauth_token => credentials.token, :oauth_token_secret => credentials.secret)
    for import in client.friends
      next if existing_contacts.collect{|x| x.email}.include?(import.id)

      new_contacts << import_contact(user, import.name, import.id, 2, import.profile_image_url)
    end
    new_contacts

  end

  def self.facebook_import(user)
    new_contacts = Array.new
    existing_contacts = user.contacts.joins(:identity).where(:identities => {:provider_id => 4})
    credentials = Identity.where(:user_id => user.id, :provider_id => 4).first

    client = FBGraph::Client.new(:client_id => FACEBOOK_ID, :secret_id => FACEBOOK_SECRET ,:token => credentials.token)

    current_time = Time.now

    for import in client.selection.me.friends.info!["data"]
      next if existing_contacts.collect{|x| x.email}.include?(import.id)

      new_contacts << import_contact(user, import.name, import.id, 4, "http://graph.facebook.com/#{import.id}/picture" )
    end

    new_contacts.each do |nc|
      profile = client.selection.user("#{nc.identity.email}").info!
      nc.identity.import_facebook(profile) unless nc.identity.created_at < current_time
    end

    new_contacts

  end

  def self.linked_in_import(user)
    new_contacts = Array.new
    existing_contacts = user.contacts.joins(:identity).where(:identities => {:provider_id => 6})
    credentials = Identity.where(:user_id => user.id, :provider_id => 6).first
    client = LinkedIn::Client.new(LINKED_IN_ID, LINKED_IN_SECRET)
    client.authorize_from_access(credentials.token, credentials.secret)

    current_time = Time.now

    for import in client.connections
      next if existing_contacts.collect{|x| x.email}.include?(import.id)

      new_contacts << import_contact(user, import.first_name + " " + import.last_name, import.id, 6, import.picture_url)
    end

    new_contacts.each do |nc|
      begin
        profile = client.profile(:id => "#{nc.identity.email}", :fields => [:location, :headline, :summary, :positions, :educations])
      rescue
        next
      end
      nc.identity.import_linked_in(profile) unless nc.identity.created_at < current_time
    end

    new_contacts
  end


  protected

  def self.import_contact(user, name, email, provider, picture_url=nil)
      identity = Identity.where(:email => email, :provider_id => provider).first
      if identity.nil?
        identity = Identity.new(:provider_id => provider, :name => name, :email => email.to_s, :picture_url => picture_url) 
        identity.skip_confirmation!
        identity.save
      end

      newcontact = Contact.find_or_create_by_user_id_and_email(:user_id => user.id, :name => name, :email => email.to_s, :identity_id => identity.id)
      newcontact.save
    newcontact
  end

end
