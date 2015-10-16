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

function guestify() {
  $(".event-agenda-attendee-fields [value='Guest']").each(function(input) {
    var $parent = $(this).parent().parent().parent().parent();
    var inputs = $parent.find(".row").addClass('hide');
    $parent.find("textarea").parent().addClass('hide');
    $parent.find(".remove_fields").text('Remove Guest');
  });
}

$(document).on('click', '.guest-attendee', function() {
  var inputs = $(this).parent().find("input");
  $.each(inputs, function(i, input){
    if(input.id.indexOf("forename") >= 0) {
      $(input).val('Guest');
      $(input).parent().addClass('hide');
    }
    else if(input.id.indexOf("surname") >= 0) {
      $(input).val('Attendee');
      $(input).parent().addClass('hide');
    }
    else if(input.id.indexOf("email") >= 0) {
      $(input).parent().addClass('hide');
    }
    else if(input.id.indexOf("phone_number") >= 0) {
      $(input).parent().addClass('hide');
    }
  });
  $(this).parent().find(".row").addClass('hide');
  $(this).parent().find("textarea").parent().addClass('hide');
  return false;
});

$(document).on('click', '.add-attendee', function() {
  $('.add_fields').click();
  return false;
});

$(document).on('click', '.add-guest', function() {
  $('.add_fields').click();
  $('.guest-attendee:last').click();
  $('.remove_fields:last').text('Remove Guest');
  return false;
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
