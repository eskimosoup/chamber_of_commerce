function slick() {
  $('.scrolling-slider .content:not(.hide)').slick({
    vertical: true,
    dots: false,
    arrows: false,
    autoplay: true,
    autoplaySpeed: 5000,
    slidesToShow: 5,
    slidesToScroll: 1,
    infinite: false,
    adaptiveHeight: false
  });
  $('.scrolling-slider .content:not(.hide)').slick('reinit');
}

$(document).ready(function() {
  $('.about-the-chamber-video-slider').slick({
    dots: true,
    arrows: false,
    autoplay: false,
    infinite: true
  });

  $('.internal-promotion').marquee({
    //speed in milliseconds of the marquee
    duration: 15000,
    //time in milliseconds before the marquee will start animating
    delayBeforeStart: 0,
    //'left' or 'right'
    direction: 'left',
    pauseOnHover: true
  });

  $('.content:not(.hide) .title:first a').mouseenter();

  slick();
});


$(document).on('click', '.about-the-chamber-arrow-left', function() {
  $('.about-the-chamber-video-slider').slick('slickPrev');
  return false;
});


$(document).on('click', '.about-the-chamber-arrow-right', function() {
  $('.about-the-chamber-video-slider').slick('slickNext');
  return false;
});

$(document).on('click', '.home-arrow-up', function(e) {
  $('.scrolling-slider .content:not(.hide)').slick('slickPrev');
  e.preventDefault();
});

$(document).on('click', '.home-arrow-down', function(e) {
  $('.scrolling-slider .content:not(.hide)').slick('slickNext');
  e.preventDefault();
});

$(document).on('click', '.content-focus-tabs a', function(e) {
  $('.scrolling-slider .content:not(.hide)').slick('unslick');

  var sliderContainer = $(this).data('slider');
  $('.scrolling-slider .content').addClass('hide');
  $(sliderContainer).removeClass('hide');
  $(this).parent().addClass('active').siblings().removeClass('active');
  $('.content:not(.hide) .title:first a').mouseenter();

  slick();
  e.preventDefault();
});

$(document).on({
    mouseenter: function () {
      var moduleType = $(this).data('item');
      var moduleId = $(this).data('id');
      $('.banner-focus').addClass('hide');
      $('#' + moduleType + '-' + moduleId).removeClass('hide');
      var height = $('.slider-focus').height();
      var offsetHeight = $('.content-focus-tabs').height();
      height -= offsetHeight
      $('.scrolling-slider').height(height);
    },
    mouseleave: function () {

    }
}, '.scrolling-slider .title a'); //pass the element as an argument to .on
