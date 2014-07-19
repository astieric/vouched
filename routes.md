(in /home/ifesdjeen/p/getvouched)
No Extensions Found: /home/ifesdjeen/.neo4jr-social
=> Configuring Compass
=> Configuring Sass
=> Loading Traits
                              list_types GET    /list_types(.:format)                                              {:action=>"index", :controller=>"list_types"}
                              list_types POST   /list_types(.:format)                                              {:action=>"create", :controller=>"list_types"}
                           new_list_type GET    /list_types/new(.:format)                                          {:action=>"new", :controller=>"list_types"}
                          edit_list_type GET    /list_types/:id/edit(.:format)                                     {:action=>"edit", :controller=>"list_types"}
                               list_type GET    /list_types/:id(.:format)                                          {:action=>"show", :controller=>"list_types"}
                               list_type PUT    /list_types/:id(.:format)                                          {:action=>"update", :controller=>"list_types"}
                               list_type DELETE /list_types/:id(.:format)                                          {:action=>"destroy", :controller=>"list_types"}
                                   about        /about(.:format)                                                   {:action=>"about", :controller=>"pages"}
                                    home        /home(.:format)                                                    {:action=>"home", :controller=>"pages"}
                                    help        /help(.:format)                                                    {:action=>"help", :controller=>"pages"}
                                 privacy        /privacy(.:format)                                                 {:action=>"privacy", :controller=>"pages"}
                                   press        /press(.:format)                                                   {:action=>"press", :controller=>"pages"}
                        new_user_session GET    /users/login(.:format)                                             {:action=>"new", :controller=>"devise/sessions"}
                            user_session POST   /users/login(.:format)                                             {:action=>"create", :controller=>"devise/sessions"}
                    destroy_user_session GET    /users/logout(.:format)                                            {:action=>"destroy", :controller=>"devise/sessions"}
                           user_password POST   /users/password(.:format)                                          {:action=>"create", :controller=>"devise/passwords"}
                       new_user_password GET    /users/password/new(.:format)                                      {:action=>"new", :controller=>"devise/passwords"}
                      edit_user_password GET    /users/password/edit(.:format)                                     {:action=>"edit", :controller=>"devise/passwords"}
                           user_password PUT    /users/password(.:format)                                          {:action=>"update", :controller=>"devise/passwords"}
                       user_registration POST   /users(.:format)                                                   {:action=>"create", :controller=>"devise/registrations"}
                   new_user_registration GET    /users/register(.:format)                                          {:action=>"new", :controller=>"devise/registrations"}
                  edit_user_registration GET    /users/edit(.:format)                                              {:action=>"edit", :controller=>"devise/registrations"}
                       user_registration PUT    /users(.:format)                                                   {:action=>"update", :controller=>"devise/registrations"}
                       user_registration DELETE /users(.:format)                                                   {:action=>"destroy", :controller=>"devise/registrations"}
                            user_vouches GET    /users/:user_id/vouches(.:format)                                  {:action=>"index", :controller=>"vouches"}
                            user_vouches POST   /users/:user_id/vouches(.:format)                                  {:action=>"create", :controller=>"vouches"}
                          new_user_vouch GET    /users/:user_id/vouches/new(.:format)                              {:action=>"new", :controller=>"vouches"}
                         edit_user_vouch GET    /users/:user_id/vouches/:id/edit(.:format)                         {:action=>"edit", :controller=>"vouches"}
                              user_vouch GET    /users/:user_id/vouches/:id(.:format)                              {:action=>"show", :controller=>"vouches"}
                              user_vouch PUT    /users/:user_id/vouches/:id(.:format)                              {:action=>"update", :controller=>"vouches"}
                              user_vouch DELETE /users/:user_id/vouches/:id(.:format)                              {:action=>"destroy", :controller=>"vouches"}
            user_vouches_requested_index GET    /users/:user_id/vouches_requested(.:format)                        {:action=>"index", :controller=>"vouches_requested"}
            user_vouches_requested_index POST   /users/:user_id/vouches_requested(.:format)                        {:action=>"create", :controller=>"vouches_requested"}
              new_user_vouches_requested GET    /users/:user_id/vouches_requested/new(.:format)                    {:action=>"new", :controller=>"vouches_requested"}
             edit_user_vouches_requested GET    /users/:user_id/vouches_requested/:id/edit(.:format)               {:action=>"edit", :controller=>"vouches_requested"}
                  user_vouches_requested GET    /users/:user_id/vouches_requested/:id(.:format)                    {:action=>"show", :controller=>"vouches_requested"}
                  user_vouches_requested PUT    /users/:user_id/vouches_requested/:id(.:format)                    {:action=>"update", :controller=>"vouches_requested"}
                  user_vouches_requested DELETE /users/:user_id/vouches_requested/:id(.:format)                    {:action=>"destroy", :controller=>"vouches_requested"}
                                   users GET    /users(.:format)                                                   {:action=>"index", :controller=>"users"}
                                   users POST   /users(.:format)                                                   {:action=>"create", :controller=>"users"}
                                new_user GET    /users/new(.:format)                                               {:action=>"new", :controller=>"users"}
                               edit_user GET    /users/:id/edit(.:format)                                          {:action=>"edit", :controller=>"users"}
                                    user GET    /users/:id(.:format)                                               {:action=>"show", :controller=>"users"}
                                    user PUT    /users/:id(.:format)                                               {:action=>"update", :controller=>"users"}
                                    user DELETE /users/:id(.:format)                                               {:action=>"destroy", :controller=>"users"}
                   identity_confirmation POST   /identities/confirmation(.:format)                                 {:action=>"create", :controller=>"confirmations"}
               new_identity_confirmation GET    /identities/confirmation/new(.:format)                             {:action=>"new", :controller=>"confirmations"}
                   identity_confirmation GET    /identities/confirmation(.:format)                                 {:action=>"show", :controller=>"confirmations"}
 autocomplete_term_name_identity_vouches GET    /identities/:identity_id/vouches/autocomplete_term_name(.:format)  {:action=>"autocomplete_term_name", :controller=>"vouches"}
                        identity_vouches GET    /identities/:identity_id/vouches(.:format)                         {:action=>"index", :controller=>"vouches"}
                        identity_vouches POST   /identities/:identity_id/vouches(.:format)                         {:action=>"create", :controller=>"vouches"}
                      new_identity_vouch GET    /identities/:identity_id/vouches/new(.:format)                     {:action=>"new", :controller=>"vouches"}
                          identity_vouch PUT    /identities/:identity_id/vouches/:id(.:format)                     {:action=>"update", :controller=>"vouches"}
                          identity_vouch DELETE /identities/:identity_id/vouches/:id(.:format)                     {:action=>"destroy", :controller=>"vouches"}
                              identities GET    /identities(.:format)                                              {:action=>"index", :controller=>"identities"}
                              identities POST   /identities(.:format)                                              {:action=>"create", :controller=>"identities"}
                            new_identity GET    /identities/new(.:format)                                          {:action=>"new", :controller=>"identities"}
                           edit_identity GET    /identities/:id/edit(.:format)                                     {:action=>"edit", :controller=>"identities"}
                                identity GET    /identities/:id(.:format)                                          {:action=>"show", :controller=>"identities"}
                                identity PUT    /identities/:id(.:format)                                          {:action=>"update", :controller=>"identities"}
                                identity DELETE /identities/:id(.:format)                                          {:action=>"destroy", :controller=>"identities"}
                 callback_oauth_consumer GET    /oauth_consumers/:id/callback(.:format)                            {:action=>"callback", :controller=>"oauth_consumers"}
                         oauth_consumers GET    /oauth_consumers(.:format)                                         {:action=>"index", :controller=>"oauth_consumers"}
                         oauth_consumers POST   /oauth_consumers(.:format)                                         {:action=>"create", :controller=>"oauth_consumers"}
                      new_oauth_consumer GET    /oauth_consumers/new(.:format)                                     {:action=>"new", :controller=>"oauth_consumers"}
                     edit_oauth_consumer GET    /oauth_consumers/:id/edit(.:format)                                {:action=>"edit", :controller=>"oauth_consumers"}
                          oauth_consumer GET    /oauth_consumers/:id(.:format)                                     {:action=>"show", :controller=>"oauth_consumers"}
                          oauth_consumer PUT    /oauth_consumers/:id(.:format)                                     {:action=>"update", :controller=>"oauth_consumers"}
                          oauth_consumer DELETE /oauth_consumers/:id(.:format)                                     {:action=>"destroy", :controller=>"oauth_consumers"}
 autocomplete_for_contact_email_contacts GET    /contacts/autocomplete_for_contact_email(.:format)                 {:action=>"autocomplete_for_contact_email", :controller=>"contacts"}
                                contacts GET    /contacts(.:format)                                                {:action=>"index", :controller=>"contacts"}
                                contacts POST   /contacts(.:format)                                                {:action=>"create", :controller=>"contacts"}
                             new_contact GET    /contacts/new(.:format)                                            {:action=>"new", :controller=>"contacts"}
                            edit_contact GET    /contacts/:id/edit(.:format)                                       {:action=>"edit", :controller=>"contacts"}
                                 contact GET    /contacts/:id(.:format)                                            {:action=>"show", :controller=>"contacts"}
                                 contact PUT    /contacts/:id(.:format)                                            {:action=>"update", :controller=>"contacts"}
                                 contact DELETE /contacts/:id(.:format)                                            {:action=>"destroy", :controller=>"contacts"}
autocomplete_term_name_archetype_vouches GET    /archetypes/:archetype_id/vouches/autocomplete_term_name(.:format) {:action=>"autocomplete_term_name", :controller=>"vouches"}
                       archetype_vouches GET    /archetypes/:archetype_id/vouches(.:format)                        {:action=>"index", :controller=>"vouches"}
                       archetype_vouches POST   /archetypes/:archetype_id/vouches(.:format)                        {:action=>"create", :controller=>"vouches"}
                     new_archetype_vouch GET    /archetypes/:archetype_id/vouches/new(.:format)                    {:action=>"new", :controller=>"vouches"}
                         archetype_vouch PUT    /archetypes/:archetype_id/vouches/:id(.:format)                    {:action=>"update", :controller=>"vouches"}
                         archetype_vouch DELETE /archetypes/:archetype_id/vouches/:id(.:format)                    {:action=>"destroy", :controller=>"vouches"}
                              archetypes GET    /archetypes(.:format)                                              {:action=>"index", :controller=>"archetypes"}
                              archetypes POST   /archetypes(.:format)                                              {:action=>"create", :controller=>"archetypes"}
                           new_archetype GET    /archetypes/new(.:format)                                          {:action=>"new", :controller=>"archetypes"}
                          edit_archetype GET    /archetypes/:id/edit(.:format)                                     {:action=>"edit", :controller=>"archetypes"}
                               archetype GET    /archetypes/:id(.:format)                                          {:action=>"show", :controller=>"archetypes"}
                               archetype PUT    /archetypes/:id(.:format)                                          {:action=>"update", :controller=>"archetypes"}
                               archetype DELETE /archetypes/:id(.:format)                                          {:action=>"destroy", :controller=>"archetypes"}
                      autocomplete_terms POST   /terms/autocomplete(.:format)                                      {:action=>"autocomplete", :controller=>"terms"}
                                   terms POST   /terms(.:format)                                                   {:action=>"create", :controller=>"terms"}
                               new_terms GET    /terms/new(.:format)                                               {:action=>"new", :controller=>"terms"}
                              edit_terms GET    /terms/edit(.:format)                                              {:action=>"edit", :controller=>"terms"}
                                   terms GET    /terms(.:format)                                                   {:action=>"show", :controller=>"terms"}
                                   terms PUT    /terms(.:format)                                                   {:action=>"update", :controller=>"terms"}
                                   terms DELETE /terms(.:format)                                                   {:action=>"destroy", :controller=>"terms"}
                                  search GET    /search(.:format)                                                  {:action=>"show", :controller=>"searches"}
                          identity_image GET    /identity_image/:id(.:format)                                      {:action=>"show", :controller=>"identity_image"}
                                 vouches GET    /vouches(.:format)                                                 {:action=>"index", :controller=>"vouches"}
                                 vouches POST   /vouches(.:format)                                                 {:action=>"create", :controller=>"vouches"}
                               new_vouch GET    /vouches/new(.:format)                                             {:action=>"new", :controller=>"vouches"}
                              edit_vouch GET    /vouches/:id/edit(.:format)                                        {:action=>"edit", :controller=>"vouches"}
                                   vouch GET    /vouches/:id(.:format)                                             {:action=>"show", :controller=>"vouches"}
                                   vouch PUT    /vouches/:id(.:format)                                             {:action=>"update", :controller=>"vouches"}
                                   vouch DELETE /vouches/:id(.:format)                                             {:action=>"destroy", :controller=>"vouches"}
                                    root        /(.:format)                                                        {:controller=>"pages", :action=>"home"}
