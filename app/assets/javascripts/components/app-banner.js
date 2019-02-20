// https://stackoverflow.com/a/8173161
(function(a,b,c){if(c in b&&b[c]){var d,e=a.location,f=/^(a|html)$/i;a.addEventListener("click",function(a){d = a.target; while(!f.test(d.nodeName))d=d.parentNode;"href"in d&&(d.href.indexOf("http")||~d.href.indexOf(e.host))&&(a.preventDefault(),e.href=d.href)},!1)}})(document,window.navigator,"standalone")

function dismissAppBanner() {
  Cookies.set('app-banner', '1', { secure: (location.protocol === 'https:'), expires: 30 });
  $('.app-banner').slideUp(250);
}

$(function() {
  if (Cookies.get('app-banner') === undefined && Modernizr.mq('(max-width: 1023px)')) {
    $('.app-banner').slideDown(250);
  }
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
