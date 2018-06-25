// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree ./vendor/foundation/libraries
//= require vendor/foundation/foundation.js
//= require vendor/foundation/foundation.equalizer.js
//= require components/google_maps.js
//= require components/home_slider.js
//= require components/toggles
//= require jquery-ui/datepicker
//= require tinymce
//= require jquery.slick
//= require cocoon
//= require vendor/jquery.colorbox-min.js
//= require cookie-consent/consent
// require_tree .

$(document).foundation({
  equalizer : {
    // Specify if Equalizer should make elements equal height once they become stacked.
    equalize_on_stack: false,
    // Allow equalizer to resize hidden elements
    act_on_hidden_el: false
  }
});

$(function() {
  setTimeout(function() {
    $(document).foundation('equalizer','reflow');
  }, 2000);

  $('.colorbox').colorbox({
    iframe: true,
    width: '675px',
    height: '675px'
  });
});

$('.patron-logos').slick({
  autoplay: true,
  autoplaySpeed: 2000,
  dots: false,
  infinite: true,
  speed: 300,
  slidesToShow: 6,
  slidesToScroll: 1,
  responsive: [
    {
      breakpoint: 1024,
      settings: {
        slidesToShow: 3,
        slidesToScroll: 3,
        infinite: true,
        dots: true
      }
    },
    {
      breakpoint: 600,
      settings: {
        slidesToShow: 2,
        slidesToScroll: 2
      }
    },
    {
      breakpoint: 480,
      settings: {
        slidesToShow: 1,
        slidesToScroll: 1
      }
    }
  ]
});
