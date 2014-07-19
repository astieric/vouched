new Vouched.Autocompletable($$('.autocomplete').first().getElement('input:[type=text]'),
                            $('%form_id%').getElement('li.suggestions').getElement('ul'),
                            function (active) {

                              var text = active.getChildren('#name').first().value
                              var id = active.getChildren('#id').first().value

                              var li = new Element('li', {
                                html: text,
                                class: 'vouch'
                              })
                              var id_el = new Element('input', {
                                value: id,
                                type: 'hidden',
                                name: '%input_name%'
                              })
                              id_el.inject(li);
                              li.inject ($('vouches'))
                            })

$$('.autocomplete').first().getElement('input:[type=text]').focus()
