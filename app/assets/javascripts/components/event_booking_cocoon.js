$(document).ready(function() {
  $("#event-attendees a.add_fields").
    data("association-insertion-method", 'before').
    data("association-insertion-node", 'this');

  $("#event-attendees").on("cocoon:after-insert", function(e, insertedItem) {
    if($(".event-agenda-attendee-fields").length == 1) {
      $("a.booker-population").show();
    }
  });
});

function setMainBookerDetails() {
  var bookerForename = $("#event_booking_forename").val();
  var bookerSurname = $("#event_booking_surname").val();
  var bookerEmail = $("#event_booking_email").val();
  var bookerPhoneNumber = $("#event_booking_phone_number").val();
  var inputs = $(".event-agenda-attendee-fields:first").find("input");
  $.each(inputs, function(i, input){
    if(input.id.indexOf("forename") >= 0) {
      $(input).val(bookerForename);
    }
    else if(input.id.indexOf("surname") >= 0) {
      $(input).val(bookerSurname);
    }
    else if(input.id.indexOf("email") >= 0) {
      $(input).val(bookerEmail);
    }
    else if(input.id.indexOf("phone_number") >= 0) {
      $(input).val(bookerPhoneNumber);
    }
    else {
      return true;
    }
  });
}