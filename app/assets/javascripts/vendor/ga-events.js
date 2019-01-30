var gaEvent = (function () {
  var self = {};

  var runEvent = function(event, element) {
    var dataAttrs = element.dataset;

    var eventData = {
      category: dataAttrs['eventCategory'],
      action: dataAttrs['eventAction'],
      label: dataAttrs['eventLabel']
    };

    if (typeof ga === 'undefined') {
      console.dir(eventData);
    }

    // Analytics
    if (eventData.category && eventData.action && typeof ga === 'function') {
      ga('send', {
        hitType: 'event',
        eventCategory: eventData.category, // required
        eventAction: eventData.action, // required
        eventLabel: eventData.label,
        // eventValue: eventValue,
        // hitCallback: function() {
        //   console.dir(eventData);
        // }
      });
    }

    // gtag
    if (eventData.category && eventData.action && typeof ga === 'function') {
      // https://stackoverflow.com/a/29434548
      var trackerName = ga.getAll()[0].get('name');
      ga(trackerName + '.send', {
        hitType: 'event',
        eventCategory: eventData.category, // required
        eventAction: eventData.action, // required
        eventLabel: eventData.label,
        transport: 'beacon',
        // eventValue: eventValue,
        // hitCallback: function() {
        //   console.dir(eventData);
        // }
      });
    }
  }

  var matchesCheck = function () {
    // IE support: https://developer.mozilla.org/en-US/docs/Web/API/Element/matches
    if (!Element.prototype.matches) {
      Element.prototype.matches = Element.prototype.msMatchesSelector;
    }
  }

  var addEvent = function (parent, evt, selector, handler) {
    parent.addEventListener(evt, function (event) {
      if (event.target.matches(selector + ', ' + selector + ' *')) {
        handler.apply(event.target.closest(selector), arguments);
      }
    }, false);
  }

  self.init = function (selector) {
    matchesCheck();
    addEvent(document, 'click', selector, function (e) {
      runEvent(e, this);
    });
  }

  return self;
}());

gaEvent.init('.ga-event');
