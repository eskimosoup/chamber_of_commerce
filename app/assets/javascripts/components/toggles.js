$(document).on("click", ".toggle-class", function(e) {
  /*
   * Example usage:
   * <a href="#div-to-go-to" data-container="#id" data-class="hidden" data-return="false">Toggle .hidden on #id and stop</a>
   *
   * Alternatively:
   * <a href="#div-to-go-to" data-container=".links" data-class="hidden" data-return="true">Toggle .hidden on .links and scroll to #div-to-go-to</a>
   */

  var toggleContainer = $(this).attr('data-container');
  var toggleClass     = $(this).attr('data-class');
  var dataReturn      = $(this).attr('data-return');

  $(toggleContainer).toggleClass(toggleClass);

  if (dataReturn === 'false') {
    e.preventDefault();
  }
});
