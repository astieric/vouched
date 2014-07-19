var a = new Vouched.Autocompletable($$('.by_archetype').first().getElement('input:[type=text]'),
                            $$('.by_archetype').first().getElement('li.suggestions').getElement('ul'),
                            function (active) {
                              var id = active.getChildren('#id').first().value
                              new Request.HTML({ 
                                update: $("archetype_vouches"), 
                                onSuccess: function () {
                                  new Fx.Reveal($('archetype_vouches')).reveal()
                                }  
                              }).get('/archetypes/' + id + '/vouches/')
                            })
a.options.requestUrl = "/archetypes/autocomplete"
a.options.model = "archetype"
//$$('.autocomplete').first().getElement('input:[type=text]').focus()
