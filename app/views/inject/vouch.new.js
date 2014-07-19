window.addEvent('domready', function() {
  new Vouched.Autocompletable($("new_vouch").getElement("input:[type=text]"),
                              $("new_vouch").getElement("li.suggestions").getElement("ul"),
                              function (active) {
                                $("new_vouch").getElement("input:[type=text]").value = active.children[0].text
                              })
  $("new_vouch").getElement("input:[type=text]").focus()
})