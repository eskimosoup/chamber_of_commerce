function slick() {
  $('.scrolling-slider .content:not(.hide)').slick({
    vertical: true,
    dots: false,
    arrows: false,
    autoplay: true,
    autoplaySpeed: 5000,
    slidesToShow: 7,
    slidesToScroll: 1,
    infinite: false
  });
  $('.scrolling-slider .content:not(.hide)').slick('reinit');
}

$(document).ready(function() {
  $('.content:not(.hide) .title:first a').mouseenter();

  slick();
});

$(document).on('click', '.home-arrow-up', function() {
  $('.scrolling-slider .content:not(.hide)').slick('slickPrev');
});

$(document).on('click', '.home-arrow-down', function() {
  $('.scrolling-slider .content:not(.hide)').slick('slickNext');
});

$(document).on('click', '.content-focus-tabs a', function() {
  $('.scrolling-slider .content:not(.hide)').slick('unslick');

  var sliderContainer = $(this).data('slider');
  $('.scrolling-slider .content').addClass('hide');
  $(sliderContainer).removeClass('hide');
  $(this).parent().addClass('active').siblings().removeClass('active');
  $('.content:not(.hide) .title:first a').mouseenter();
  slick();
});

$(document).on({
    mouseenter: function () {
      var moduleType = $(this).data('item');
      var moduleId = $(this).data('id');
      $('.banner-focus').addClass('hide');
      $('#' + moduleType + '-' + moduleId).removeClass('hide');
    },
    mouseleave: function () {

    }
}, '.scrolling-slider .title a'); //pass the element as an argument to .on
