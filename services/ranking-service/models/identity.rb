class Identity < ActiveRecord::Base
  has_uuid

  has_many :educations, :as => :resource
  has_many :employments, :as => :resource

  belongs_to :provider
  belongs_to :user

  has_many :contacts


  def apply_omniauth data
    if ["twitter", "facebook", "github","linked_in"].include?(data['provider'])
      self.token  = data['credentials']['token']
      self.secret = data['credentials']['secret']

      self.name     = data['user_info']['name']
      self.nickname = data['user_info']['nickname']
    end

    case data['provider'].to_sym
    when :twitter
      self.url = "http://twitter.com/#{data['user_info']['nickname']}"
    when :linked_in
      self.name     = data['user_info'][:name]
      self.nickname = "#{data['user_info']['first_name']}.#{data['user_info']['last_name']}".downcase
    when :github
      self.url = "http://github.com#{data['user_info']['nickname']}"
    when :facebook
      self.url = data['extra']['user_hash']['link']
      self.email = data['extra']['user_hash']['email']
    end
  end

  def import_facebook(profile)

    text = ""

    unless profile.work.nil?
      profile.work.each do |w|
        unless w.start_date.nil? 
          start_year = w.start_date[0..3] 
          start_month = w.start_date[5..6]
        end

        unless w.end_date.nil? 
          end_year = w.end_date[0..3] 
          end_month = w.end_date[5..6]
        end

        unless w.position.nil?
          title = w.position.name
        end

        unless w.employer.nil?
          company_name = w.employer.name
        end

        text << " " << title << " " << w.summary

        Employment.create(:provider_id => 4, :resource_id => self.id, :resource_type => 'Identity', :summary => w.description, :title => title, :start_year => start_year, :start_month => start_month, :end_year => end_year, :end_month => end_month, :company_name => company_name)
      end
    end

    unless profile.education.nil?
      profile.education.each do |e|

        unless e.concentration.nil?
          field_of_study = e.concentration.first.name
        end

        unless e.school.nil?
          school_name = e.school.name
        end

        Education.create(:provider_id => 4, :resource_id => self.id, :resource_type => 'Identity', :field_of_study => field_of_study, :school_name => school_name, :end_year => e.year )
      end
    end

    options = {:headers => {'Content-Type' => 'application/json'}, :body => {"text" => text, "priority" => 2}.to_json }

    HTTParty.post(URI.escape("http://localhost:7100/api/v1/extractions"), options).parsed_response.each do |t|
      ResourceTerm.find_or_create_by_resource_id_and_term_id(:resource_id => self.id, :term_id => t["term"]["id"], :resource_type => "Identity")
    end

  end

  def import_linked_in(profile)

    text = ""

    unless profile.positions.empty?
      profile.positions.each do |pos|
        text << " " << pos.title << " " << pos.summary
        Employment.create(:provider_id => 6, :resource_id => self.id, :resource_type => 'Identity', :summary => pos.summary, :title => pos.title, :company_name => pos.company.name, :start_year => pos.start_year, :start_month => pos.start_month, :end_year => pos.end_year, :end_month => pos.end_month)
      end
    end

    unless profile.education.empty?
      profile.education.each do |edu|
        Education.create(:provider_id => 6, :resource_id => self.id, :resource_type => 'Identity', :degree => edu.degree, :field_of_study => edu.field_of_study, :school_name => edu.school_name, :start_year => edu.start_year, :start_month => edu.start_month, :end_year => edu.end_year, :end_month => edu.end_month)
      end
    end

    options = {:headers => {'Content-Type' => 'application/json'}, :body => {"text" => text, "priority" => 2}.to_json }

    HTTParty.post(URI.escape("http://localhost:7100/api/v1/extractions"), options).parsed_response.each do |t|
      ResourceTerm.find_or_create_by_resource_id_and_term_id(:resource_id => self.id, :term_id => t["term"]["id"], :resource_type => "Identity")
    end

  end

end
