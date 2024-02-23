const tapTapGo = (function () {
  var self = {};
  var selector;
  var lastElement;

  var bindEvents = function () {
    var elements = document.querySelectorAll(selector);
    for (let i = 0, n = elements.length; i < n; i++) {
      elements[i].parentElement.addEventListener('click', processInteraction);
    };
  }

  // https://stackoverflow.com/a/12981248
  var getParents = function (element) {
    var parents = [];
    var p = element.parentNode;

    while (p !== document) {
      var o = p;
      parents.push(o);
      p = o.parentNode;
    }

    parents.push(document);
    return parents;
  }

  var processInteraction = function (event) {
    if (getParents(event.target).includes(lastElement) != true) {
      event.preventDefault();
    }

    lastElement = event.target.parentNode;
  }

  self.init = function (tmpSelector) {
    selector = tmpSelector
    bindEvents();
  }

  return self;
}());

document.addEventListener('DOMContentLoaded', tapTapGo.init('.header-navigation-dropdown-list'));
