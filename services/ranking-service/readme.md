== Sinatra Services

Using the Thin Web server
thin -C thin-development.yml -R config.ru start
thin -C thin-development.yml -R config.ru stop

thin -C thin-production.yml -R config.ru start


== Ranking Service

The Ranking Service is used to create an ordered list of users.

The Rest Service receives requests that contain various parameter passed in via POST.

  post /api/v1/ranking                    -- This request will return user ids in JSON + ranks
  post /api/v1/vouched/:user_id/:level    -- This request will calculate and save the network of the user_id at the specified level.


These can be tested via:
  curl -i -H "Accept: application/json" -X POST -d '{"location":"dp3wjztvtwnw","radius":4, "unlocated":1, "terms":["6d65fbc8-fe56-11df-af1e-003048c3cf84","6d65ff92-fe56-11df-af1e-003048c3cf84"]}' http://localhost:9292/api/v1/ranking
  curl -i -H "Accept: application/json" -H 'Content-Length: 0' -X POST http://localhost:9292/api/v1/vouched/768ff534-0165-11e0-92a3-003048c3cf84/2

Default Parameters:
  location   = params["geo_hash"]  || "9q8yyk8yuv5x" # San Francisco, CA, USA as Default Location
  radius     = params["radius"]    || 3              # 50 Miles as Default Radius
  limit      = params["limit"]     || 100            # 100 Users as Default Limit
  offset     = params["offset"]    || 0              # 0 Default Offset
  unlocated  = params["unlocated"] || 1              # 1 Default include users with no locations

bundle install
bundle exec ruby ranking_consumer.rb     # To start the Consumer
bundle exec ruby ranking_logger.rb       # To start the Logger


Dependencies:
Neo4j
Redis

"dp3wjztvtwnw"                         : Chicago GeoHash
"6d65fbc8-fe56-11df-af1e-003048c3cf84" : term_id for "Ruby"
"6d65ff92-fe56-11df-af1e-003048c3cf84" : term_id for "Ruby on Rails"

== Rank Service

The Rank Service is used to update the TermRank of users as Vouches are updated constantly and dynamically.  
One caveat is that we do not want a Rank job to start for a Term that is currently running.

Fresh Request:
Create Rank with Term_Id
Add Term_Id to work_queue

Another comes in:
Add 1 to existing rank request.

Already Started :
Add 1 to existing rank request.

Service Starts:
Set requests to zero.

Service Ends
If requests > 0 then Add Term_Id to work_queue


The Rest Service receives requests to compute Ranks on specific terms submitted or for all Terms.

  put /api/v1/ranks/:term_id   -- This request will generate a message to compute the rank for the specified term_id
  put /api/v1/ranks            -- This request will generate multiple messages to compute the ranks for each term that has new vouches.

These can be tested via:
  curl -X PUT -H 'Content-Length: 0' http://localhost:9292/api/v1/ranks
  curl -X PUT -H 'Content-Length: 0' http://localhost:9292/api/v1/ranks/:term_id
  curl -X PUT -H 'Content-Length: 0' http://localhost:9292/api/v1/ranks/6d65fbc8-fe56-11df-af1e-003048c3cf84


The Logger echos the rank request recieved.
The Consumer performs the actual ranking job, it is subscribed to a message queue and waits for messages to begin computing ranks.

We are using the RabbitMQ server and the Bunny AMQP client library:

Exchange: rank
Work Queue: rank_work_queue
Log Queue: rank_log_queue

The message payload is the term_id to start processing.


bundle install
bundle exec ruby rank_logger.rb       # To start the Logger
bundle exec ruby rank_consumer.rb     # To start the Consumer

== Import Service

The import service is used to retrive friends and contacts from 3rd party services.

  put /api/v1/import/:type/:user_id

  :type is one of the following: "Google", "Yahoo", "Live", "Twitter", "Facebook", "Linked In"
