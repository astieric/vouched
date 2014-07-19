# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110321224639) do

  create_table "archetypes", :id => false, :force => true do |t|
    t.string   "id",          :limit => 36,                      :null => false
    t.string   "name"
    t.string   "abstract",    :limit => 1000
    t.string   "user_id",     :limit => 36
    t.boolean  "public",                      :default => false
    t.text     "description"
    t.integer  "term_count",                  :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "archetypes", ["id"], :name => "index_archetypes_on_id", :unique => true
  add_index "archetypes", ["user_id"], :name => "index_archetypes_on_user_id"

  create_table "cities", :force => true do |t|
    t.integer "country_id",               :null => false
    t.integer "region_id",                :null => false
    t.string  "name",       :limit => 50, :null => false
    t.string  "latitude",   :limit => 10
    t.string  "longitude",  :limit => 10
    t.string  "geo_hash",   :limit => 12
  end

  add_index "cities", ["name"], :name => "index_cities_on_name"

  create_table "companies", :force => true do |t|
    t.integer  "jigsawid"
    t.string   "name",           :limit => 200, :null => false
    t.string   "website",        :limit => 200
    t.string   "phone",          :limit => 50
    t.string   "address",        :limit => 200
    t.string   "city_name",      :limit => 100
    t.string   "state",          :limit => 100
    t.string   "zip",            :limit => 50
    t.string   "country_name",   :limit => 100
    t.integer  "industry_id"
    t.integer  "subindustry_id"
    t.integer  "city_id"
    t.integer  "region_id"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "consumer_tokens", :id => false, :force => true do |t|
    t.string   "id",         :limit => 36,   :null => false
    t.string   "user_id",    :limit => 36
    t.string   "type",       :limit => 30
    t.string   "token",      :limit => 1024
    t.string   "secret"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "consumer_tokens", ["id"], :name => "index_consumer_tokens_on_id", :unique => true
  add_index "consumer_tokens", ["user_id"], :name => "index_consumer_tokens_on_user_id"

  create_table "contacts", :id => false, :force => true do |t|
    t.string   "id",          :limit => 36, :null => false
    t.string   "user_id",     :limit => 36, :null => false
    t.string   "identity_id", :limit => 36, :null => false
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contacts", ["email"], :name => "index_contacts_on_email"
  add_index "contacts", ["id"], :name => "index_contacts_on_id", :unique => true
  add_index "contacts", ["name"], :name => "index_contacts_on_name"
  add_index "contacts", ["user_id"], :name => "index_contacts_on_user_id"

  create_table "countries", :force => true do |t|
    t.string  "code",      :limit => 10,  :null => false
    t.string  "shortname", :limit => 50,  :null => false
    t.string  "fullname",  :limit => 100, :null => false
    t.integer "isonumber"
    t.string  "latitude",  :limit => 10
    t.string  "longitude", :limit => 10
    t.string  "geo_hash",  :limit => 12
  end

  add_index "countries", ["fullname"], :name => "index_countries_on_fullname", :unique => true
  add_index "countries", ["shortname"], :name => "index_countries_on_shortname", :unique => true

  create_table "educations", :id => false, :force => true do |t|
    t.string   "id",             :limit => 36,                 :null => false
    t.string   "resource_id",    :limit => 36
    t.string   "resource_type",  :limit => 20
    t.string   "school_name"
    t.string   "degree"
    t.string   "field_of_study"
    t.string   "activities",     :limit => 500
    t.integer  "start_year"
    t.integer  "start_month"
    t.integer  "end_year"
    t.integer  "end_month"
    t.integer  "school_id"
    t.string   "education"
    t.integer  "provider_id",                   :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "educations", ["resource_id"], :name => "index_educations_on_resource_id"
  add_index "educations", ["school_id"], :name => "index_educations_on_school_id"

  create_table "employments", :id => false, :force => true do |t|
    t.string   "id",            :limit => 36,                     :null => false
    t.string   "resource_id",   :limit => 36
    t.string   "resource_type", :limit => 20
    t.string   "title"
    t.string   "summary"
    t.integer  "start_year"
    t.integer  "start_month"
    t.integer  "end_year"
    t.integer  "end_month"
    t.boolean  "is_current",                   :default => false
    t.string   "company_name",  :limit => 200
    t.integer  "company_id"
    t.integer  "provider_id",                  :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "employments", ["company_id"], :name => "index_employments_on_company_id"
  add_index "employments", ["resource_id"], :name => "index_employments_on_resource_id"

  create_table "identities", :id => false, :force => true do |t|
    t.string   "id",                   :limit => 36,                  :null => false
    t.string   "user_id",              :limit => 36
    t.string   "name"
    t.string   "nickname"
    t.string   "url"
    t.string   "email"
    t.integer  "provider_id",                          :default => 1
    t.string   "token",                :limit => 1024
    t.string   "secret"
    t.string   "picture_url"
    t.integer  "term_count",                           :default => 0
    t.integer  "user_node"
    t.integer  "identity_node"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "identities", ["confirmation_token"], :name => "index_identities_on_confirmation_token", :unique => true
  add_index "identities", ["email", "provider_id"], :name => "index_identities_on_email", :unique => true
  add_index "identities", ["id"], :name => "index_identities_on_id", :unique => true
  add_index "identities", ["identity_node"], :name => "index_identities_on_identity_node"
  add_index "identities", ["name"], :name => "index_identities_on_name"
  add_index "identities", ["nickname"], :name => "index_identities_on_nickname"
  add_index "identities", ["provider_id"], :name => "index_identities_on_provider_id"
  add_index "identities", ["user_id"], :name => "index_identities_on_user_id"
  add_index "identities", ["user_node"], :name => "index_identities_on_user_node"

  create_table "industries", :force => true do |t|
    t.string "name", :limit => 200, :null => false
  end

  add_index "industries", ["name"], :name => "index_industries_on_name", :unique => true

  create_table "jobs", :id => false, :force => true do |t|
    t.string   "id",           :limit => 36,                  :null => false
    t.string   "title",                                       :null => false
    t.text     "description",                                 :null => false
    t.string   "city_name",                                   :null => false
    t.string   "state_code",                                  :null => false
    t.string   "country_code",                                :null => false
    t.string   "url",          :limit => 4000
    t.string   "employer",                                    :null => false
    t.string   "guid",                                        :null => false
    t.integer  "status_id",                    :default => 1, :null => false
    t.integer  "term_count",                   :default => 0, :null => false
    t.string   "user_id",      :limit => 36,                  :null => false
    t.integer  "country_id"
    t.integer  "region_id"
    t.integer  "city_id"
    t.integer  "company_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "geo_hash",     :limit => 12
  end

  add_index "jobs", ["city_id"], :name => "index_jobs_on_city_id"
  add_index "jobs", ["company_id"], :name => "index_jobs_on_company_id"
  add_index "jobs", ["country_id"], :name => "index_jobs_on_country_id"
  add_index "jobs", ["guid"], :name => "index_jobs_on_guid", :unique => true
  add_index "jobs", ["id"], :name => "index_jobs_on_id", :unique => true
  add_index "jobs", ["region_id"], :name => "index_jobs_on_region_id"
  add_index "jobs", ["user_id"], :name => "index_jobs_on_user_id"

  create_table "list_types", :force => true do |t|
    t.string "name", :limit => 50, :null => false
  end

  add_index "list_types", ["name"], :name => "index_list_types_on_name"

  create_table "lists", :id => false, :force => true do |t|
    t.string   "id",            :limit => 36,                    :null => false
    t.string   "name",          :limit => 50,                    :null => false
    t.integer  "list_type_id",                                   :null => false
    t.string   "user_id",       :limit => 36,                    :null => false
    t.boolean  "public",                      :default => false, :null => false
    t.string   "resource_id",   :limit => 36
    t.string   "resource_type", :limit => 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lists", ["id"], :name => "index_lists_on_id", :unique => true
  add_index "lists", ["name"], :name => "index_lists_on_name"
  add_index "lists", ["resource_id"], :name => "index_lists_on_resource_id"
  add_index "lists", ["user_id", "list_type_id"], :name => "index_lists_on_user_id_and_list_type_id"

  create_table "message_recipients", :id => false, :force => true do |t|
    t.string   "id",            :limit => 36, :null => false
    t.string   "message_id",                  :null => false
    t.string   "receiver_id",   :limit => 36, :null => false
    t.string   "receiver_type",               :null => false
    t.string   "kind",                        :null => false
    t.integer  "position"
    t.string   "state",                       :null => false
    t.datetime "hidden_at"
  end

  add_index "message_recipients", ["id"], :name => "index_message_recipients_on_id", :unique => true
  add_index "message_recipients", ["message_id", "kind", "position"], :name => "index_message_recipients_on_message_id_and_kind_and_position", :unique => true

  create_table "messages", :id => false, :force => true do |t|
    t.string   "id",          :limit => 36, :null => false
    t.string   "sender_id",                 :null => false
    t.string   "sender_type",               :null => false
    t.text     "subject"
    t.text     "body"
    t.string   "state",                     :null => false
    t.datetime "hidden_at"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages", ["id"], :name => "index_messages_on_id", :unique => true

  create_table "phrases", :force => true do |t|
    t.string "name", :limit => 4000
  end

  add_index "phrases", ["name"], :name => "index_phrases_on_name"

  create_table "providers", :force => true do |t|
    t.string "name", :null => false
  end

  add_index "providers", ["name"], :name => "index_providers_on_name", :unique => true

  create_table "rank_jobs", :force => true do |t|
    t.string   "term_id",    :limit => 36
    t.boolean  "started",                  :default => false
    t.boolean  "finished",                 :default => false
    t.integer  "requests",                 :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ranking_jobs", :force => true do |t|
    t.string   "user_id",    :limit => 36,                    :null => false
    t.integer  "level",                    :default => 1,     :null => false
    t.boolean  "started",                  :default => false, :null => false
    t.boolean  "finished",                 :default => false, :null => false
    t.integer  "requests",                 :default => 1,     :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recommended_jobs", :id => false, :force => true do |t|
    t.string   "id",         :limit => 36, :null => false
    t.string   "user_id",    :limit => 36, :null => false
    t.string   "job_id",     :limit => 36, :null => false
    t.integer  "job_rank",                 :null => false
    t.integer  "term_count",               :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regions", :force => true do |t|
    t.integer "country_id",                :null => false
    t.string  "code",       :limit => 10,  :null => false
    t.string  "name",       :limit => 100, :null => false
    t.string  "latitude",   :limit => 10
    t.string  "longitude",  :limit => 10
    t.string  "geo_hash",   :limit => 12
  end

  add_index "regions", ["name"], :name => "index_regions_on_name"

  create_table "resource_lists", :id => false, :force => true do |t|
    t.string   "id",            :limit => 36,                :null => false
    t.string   "resource_id",   :limit => 36,                :null => false
    t.string   "resource_type", :limit => 20,                :null => false
    t.string   "list_id",       :limit => 36,                :null => false
    t.integer  "position",                    :default => 1, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "resource_lists", ["id"], :name => "index_resource_lists_on_id", :unique => true
  add_index "resource_lists", ["list_id", "resource_id"], :name => "index_resource_lists_on_list_id_and_resource_id", :unique => true
  add_index "resource_lists", ["list_id"], :name => "index_resource_lists_on_list_id"
  add_index "resource_lists", ["resource_id"], :name => "index_resource_lists_on_resource_id"

  create_table "resource_terms", :id => false, :force => true do |t|
    t.string "id",            :limit => 36,                  :null => false
    t.string "resource_id",   :limit => 36
    t.string "resource_type", :limit => 20
    t.string "term_id",       :limit => 36,                  :null => false
    t.float  "term_rank",                   :default => 0.0, :null => false
  end

  add_index "resource_terms", ["id"], :name => "index_resource_terms_on_id", :unique => true
  add_index "resource_terms", ["resource_id"], :name => "index_resource_terms_on_resource_id"
  add_index "resource_terms", ["term_id"], :name => "index_resource_terms_on_term_id"

  create_table "roles", :force => true do |t|
    t.string   "name",              :limit => 40
    t.string   "authorizable_type", :limit => 40
    t.string   "authorizable_id",   :limit => 36
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["authorizable_id"], :name => "index_roles_on_authorizable_id"
  add_index "roles", ["authorizable_type"], :name => "index_roles_on_authorizable_type"
  add_index "roles", ["name", "authorizable_id", "authorizable_type"], :name => "index_roles_on_name_and_authorizable_id_and_authorizable_type", :unique => true
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "roles_users", :id => false, :force => true do |t|
    t.string   "user_id",    :limit => 36
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles_users", ["role_id"], :name => "index_roles_users_on_role_id"
  add_index "roles_users", ["user_id", "role_id"], :name => "index_roles_users_on_user_id_and_role_id", :unique => true
  add_index "roles_users", ["user_id"], :name => "index_roles_users_on_user_id"

  create_table "schools", :force => true do |t|
    t.string   "name",       :limit => 200, :null => false
    t.string   "website",    :limit => 100, :null => false
    t.integer  "country_id",                :null => false
    t.integer  "region_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schools", ["country_id"], :name => "index_schools_on_country_id"
  add_index "schools", ["name"], :name => "index_schools_on_name"
  add_index "schools", ["region_id"], :name => "index_schools_on_region_id"

  create_table "subindustries", :force => true do |t|
    t.string  "name",        :limit => 200
    t.integer "industry_id",                :null => false
  end

  add_index "subindustries", ["industry_id"], :name => "index_subindustries_on_industry_id"
  add_index "subindustries", ["name"], :name => "index_subindustries_on_name"

  create_table "terms", :id => false, :force => true do |t|
    t.string   "id",             :limit => 36,                                    :null => false
    t.string   "name",                                                            :null => false
    t.integer  "resource_count",               :default => 0
    t.datetime "ranked_at",                    :default => '1970-01-01 00:00:00', :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "terms", ["name"], :name => "index_terms_on_name", :unique => true

  create_table "translations", :force => true do |t|
    t.string  "term_id",   :limit => 36
    t.integer "phrase_id"
    t.integer "priority",                :default => 1
  end

  add_index "translations", ["phrase_id"], :name => "index_translations_on_phrase_id"
  add_index "translations", ["term_id"], :name => "index_translations_on_term_id"

  create_table "users", :id => false, :force => true do |t|
    t.string   "id",                   :limit => 36,                  :null => false
    t.string   "username",                                            :null => false
    t.integer  "user_node"
    t.string   "linkedin_token"
    t.string   "linkedin_secret"
    t.integer  "term_count",                          :default => 0
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "geo_hash",             :limit => 12
    t.integer  "location_id"
    t.string   "location_type",        :limit => 10
    t.integer  "radius"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["id"], :name => "index_users_on_id", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["user_node"], :name => "index_users_on_user_node", :unique => true
  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  create_table "versions", :force => true do |t|
    t.string   "item_type",                :null => false
    t.string   "item_id",    :limit => 36, :null => false
    t.string   "event",                    :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

  create_table "vouches", :id => false, :force => true do |t|
    t.string   "id",             :limit => 36, :null => false
    t.string   "requester_id",   :limit => 36
    t.string   "requester_type", :limit => 20
    t.string   "grantor_id",     :limit => 36
    t.string   "grantor_type",   :limit => 20
    t.string   "term_id",        :limit => 36
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status_id"
  end

  add_index "vouches", ["grantor_id"], :name => "index_vouches_on_grantor_id"
  add_index "vouches", ["id"], :name => "index_vouches_on_id", :unique => true
  add_index "vouches", ["requester_id"], :name => "index_vouches_on_requester_id"
  add_index "vouches", ["term_id"], :name => "index_vouches_on_term_id"

end
