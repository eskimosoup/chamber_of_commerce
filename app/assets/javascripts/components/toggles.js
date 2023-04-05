$(document).on("click", ".toggle-class", function (e) {
  /*
   * Example usage:
   * <a href="#div-to-go-to" data-container="#id" data-class="hidden" data-return="false">Toggle .hidden on #id and stop</a>
   *
   * Alternatively:
   * <a href="#div-to-go-to" data-container=".links" data-class="hidden" data-return="true">Toggle .hidden on .links and scroll to #div-to-go-to</a>
   */

  var toggleContainer = $(this).attr("data-container");
  var toggleClass = $(this).attr("data-class");
  var dataReturn = $(this).attr("data-return");

  $(toggleContainer).toggleClass(toggleClass);

  if (dataReturn === "false") {
    e.preventDefault();
  }
});

$(document).on("click", ".add-event-attendees", function (e) {
  /*
   * Example usage:
   * <a href="#div-to-go-to" data-container="#id" data-class="hidden" data-return="false">Toggle .hidden on #id and stop</a>
   *
   * Alternatively:
   * <a href="#div-to-go-to" data-container=".links" data-class="hidden" data-return="true">Toggle .hidden on .links and scroll to #div-to-go-to</a>
   */

  var toggleContainer = $(this).attr("data-container");
  var toggleClass = $(this).attr("data-class");
  var dataReturn = $(this).attr("data-return");

  $(toggleContainer).toggleClass(toggleClass);

  if ($(this).attr("data-clicked") === undefined) {
    $(".add_fields").click();
    setMainBookerDetails();
    $(".booker-population, .remove_fields, .guest-attendee").hide();
    $(this).attr("data-clicked", "true");
  }

  if (dataReturn === "false") {
    e.preventDefault();
  }
});

$(document).on("click", ".add-event-attendees-and-proceed", function (e) {
  e.preventDefault();

  if ($(this).attr("data-clicked") === undefined) {
    $(".add_fields").click();
    setMainBookerDetails();
    $(".event-agenda-attendee-fields.nested-fields").hide();
    $(this).attr("data-clicked", "true");
  }

  $("#new_event_booking").trigger("submit");
});
