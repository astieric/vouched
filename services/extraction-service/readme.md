The Extraction Service is used to extract Terms from incoming text.

The Rest Service receives requests to contain a "text" parameter passed in via POST.

  post /api/v1/extractions   -- This request will return term ids in JSON

These can be tested via:
  curl -i -H "Accept: application/json" -X POST -d '{"text":"Ruby on Rails and Java","priority":1}' http://localhost:7100/api/v1/extractions

bundle install
bundle exec rackup -p 7100              # To start the Rest service


Using the Thin Web server
bundle exec thin -C thin-development.yml -R config.ru start
bundle exec thin -C thin-development.yml -R config.ru stop

bundle exec thin -C thin-production.yml -R config.ru start