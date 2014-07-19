# edit this file to contain credentials for the OAuth services you support.
# each entry needs a corresponding token model.
#
# eg. :twitter => TwitterToken, :hour_feed => HourFeedToken etc.
#
# OAUTH_CREDENTIALS={
#   :twitter=>{
#     :key=>"",
#     :secret=>""
#   },
#   :google=>{
#     :key=>"",
#     :secret=>"",
#     :scope=>"" # see http://code.google.com/apis/gdata/faq.html#AuthScopes
#   },
#   :agree2=>{
#     :key=>"",
#     :secret=>""
#   },
#   :fireeagle=>{
#     :key=>"",
#     :secret=>""
#   },
#   :hour_feed=>{
#     :key=>"",
#     :secret=>"",
#     :options=>{ # OAuth::Consumer options
#       :site=>"http://hourfeed.com" # Remember to add a site for a generic OAuth site
#     }
#   },
#   :nu_bux=>{
#     :key=>"",
#     :secret=>"",
#     :super_class=>"OpenTransactToken",  # if a OAuth service follows a particular standard 
#                                         # with a token implementation you can set the superclass
#                                         # to use
#     :options=>{ # OAuth::Consumer options
#       :site=>"http://nubux.heroku.com" 
#     }
#   }
# }
# 

#Yahoo
#http://developer.yahoo.com/oauth/
#Yahoo Application ID = nXl5Q462

OAUTH_CREDENTIALS={
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
} unless defined? OAUTH_CREDENTIALS

load 'oauth/models/consumers/service_loader.rb'