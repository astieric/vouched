window.addEvent('domready', function() {
  var slider = new Fx.Slide($$('div.login-top').first())
  slider.hide()
  if ($$('a.show_login').length) {
    $$('a.show_login').first().addEvent('click', function(e){
      e.stop();
      slider.slideIn();
    });
  }

  $$('a.hide_login').addEvent('click', function(e){
    e.stop();
    slider.slideOut();
  });

  new Vouched.Repeatable ($$('div.login-top').getElement('#user_username').first(), 'Username')
  new Vouched.Repeatable ($$('div.login-top').getElement('#user_password').first(), 'Password')

  $$('.navigation').each(function (nav) {
    nav.getElements("li").each(function (el) {
      if($chk(el.getElement("ul"))) {
        var morph= new Fx.Morph(el.getElement("ul"), {wait: false, duration: 1000, transition: Fx.Transitions.Back.easeOut, link: 'cancel'})  
        var height = el.getElement("ul").getElements("li").length * 20
        el.getElement("ul").style.height = 0;
        el.addEvent("mouseenter", function () {
          morph.start({ 'height': [0, height] })
        })
        el.addEvent("mouseleave", function () {
          morph.start({ 'height': [height, 0] })
        })
      }
    })
  })
})



	
	

