module OmniauthResults
  def get_results_for provider
    case provider
    when :twitter
      {
        "user_info" => {
          "name" => "TwitterName", 
          "location" => "TwitterLocation", 
          "urls" => {"Website" => "http://twitter.test.com"}, 
          "nickname" => "TwitterNickname"
        },
        "credentials" => {
          "token" => "TwitterToken",
          "secret" => "TwitterSecret"
        },
        "extra"=> {
          "user_hash"=> {
            "name" => "TwitterHashName", 
            "location" => "TwitterHashLocation", 
            "url" => "http://twitter.hash.url", 
            "description" => "TwitterHashDescription"
          }
        },
        "provider" => "twitter"        
      }
    when :facebook
      {
        "user_info"=> {
          "name" => "FacebookName", 
          "urls"=>{"Facebook" => "http://www.facebook.com/facebook.name", "Website"=>"http://facebook.website.com"}, 
          "nickname" => "FacebookNickname", 
          "last_name" => "FacebookFirstName",      
          "first_name" => "FacebookLastName"
        }, 
        "credentials" => {
          "token" => "FacebookToken",
          "secret" => "FacebookSecret"
        },
        "extra"=> {
          "user_hash"=> {
            "name" => "FacebookHashName", 
            "first_name" => "FacebookFirstName",
            "last_name" => "FacebookLastName", 
            "link" => "http://www.facebook.com/facebook.name", 
            "email" => "facebook@email.com"
          }
        }, 
        "provider" => "facebook"
      }
    when :linked_in
      {
        "user_info"=>{
          "location" => "LinkedInLocation", 
          "urls"=> {"Blog" => "http://linked_in_blog" }, 
          "last_name" => "LinkedInLastName", 
          "first_name" => "LinkedInFirstName",
          :name =>"LinkedInName", 
          "description" => "LinkedInDescription"
        },
        "credentials" => {
          "token" => "LinkedInToken",
          "secret" => "LinkedInSecret"
        }, 
        "provider" => "linked_in"
      }
    when :github
      {
        "user_info"=>{
          "name" =>"GithubName", 
          "nickname" =>"GithubNickName"
        },
        "credentials" => {
          "token" => "GithubToken",
          "secret" => "GithubSecret"
        }, 
        "provider" => "github"
      }
    end
  end
end
