$(document).ready(function() {
  $("#event-attendees a.add_fields").
    data("association-insertion-method", 'before').
    data("association-insertion-node", 'this');
});