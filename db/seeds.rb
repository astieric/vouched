# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)

require "activerecord-import/mysql"

require "#{Rails.root}/db/data/bulk_loader"
require "#{Rails.root}/db/data/providers"
require "#{Rails.root}/db/data/countries"
require "#{Rails.root}/db/data/regions"
require "#{Rails.root}/db/data/cities"
require "#{Rails.root}/db/data/industries"
require "#{Rails.root}/db/data/subindustries"
require "#{Rails.root}/db/data/schools"
require "#{Rails.root}/db/data/archetypes"
require "#{Rails.root}/db/data/list_types"
require "#{Rails.root}/db/data/related_archetypes"
require "#{Rails.root}/db/data/terms"
require "#{Rails.root}/db/data/phrases"
require "#{Rails.root}/db/data/translations"
require "#{Rails.root}/db/data/test_data"
