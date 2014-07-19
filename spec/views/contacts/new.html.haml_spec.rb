require 'spec_helper'

describe "contacts/new.html.haml" do
  before(:each) do
    @contact = assign(:contact, Contact.new)

    assign(:cities, [
      stub_model(City,
        :name => "Name",
        :country_id => 1,
        :region_id => 1
      ),
      stub_model(City,
        :name => "Name",
        :country_id => 2,
        :region_id => 2
      )
    ])

    @consumer_tokens = [
      stub_model(ConsumerToken,
        :new_record? => true,
        :user_id => "MyString",
        :identity_id => "MyString",
        :type => "MyString",
        :token => "MyString",
        :secret => "MyString"
        ),
      stub_model(ConsumerToken,
        :new_record? => true,
        :user_id => "MyString",
        :identity_id => "MyString",
        :type => "MyString",
        :token => "MyString",
        :secret => "MyString"
        )
    ]
    assign(:consumer_tokens,@consumer_tokens)

  oauth_crendentials={
     :google=>{
       :key=>"getvouched.com",
       :secret=>"JnQtdACMEfx6AZvEy1qpHSrc",
       :scope=>"http://www-opensocial.googleusercontent.com/api/people/"
     },
     :yahoo=>{
       :key=>"dj0yJmk9MzJocEFNRFV0cGlNJmQ9WVdrOWJsaHNOVkUwTmpJbWNHbzlNVFEwT1RFNE1qZzJNZy0tJnM9Y29uc3VtZXJzZWNyZXQmeD01Yg--",
       :secret=>"575ab0ce768191de6ae27e7b1fbcf88a1e770c07",
       :scope=>"http://appstore.apps.yahooapis.com/social/rest/people/",
     }
    }

    assign(:services,oauth_crendentials.keys-@consumer_tokens.collect{|c| c.class.service_name})

    @identities = [
      stub_model(Identity,
        :new_record? => true,
        :name => "MyString",
        :handle => "MyString",
        :provider => stub_model(Provider, 
          :new_record? => true,
          :name => "MyString")
       ),
      stub_model(Identity,
        :new_record? => true,
        :name => "MyString",
        :handle => "MyString",
        :provider => stub_model(Provider, 
          :new_record? => true,
          :name => "MyString")
       )
    ]

  end

  it "renders new contact form" do
    render

    rendered.should have_selector("form", :action => contacts_path, :method => "post") do |form|
      form.should have_selector("input#contact_name", :name => "contact[name]")
      form.should have_selector("input#contact_email", :name => "contact[email]")
    end
  end
end
