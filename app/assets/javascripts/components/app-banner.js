function dismissAppBanner() {
  Cookies.set('app-banner', '1', { secure: (location.protocol === 'https:'), expires: 30 });
  $('.app-banner').slideUp(250);
}

$(function() {
  //if(Cookies.get('app-banner') === undefined) {
    $('.app-banner').slideDown(250);
  //}
});

$(document).on('click', '.app-banner__dismiss', function() {
  dismissAppBanner();
  return false;
})

$(document).on('click', '.app-banner__button', function() {
  dismissAppBanner();
  window.url = $(this).href();
  return false;
})
