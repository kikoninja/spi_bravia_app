var elementIn = function (element, box) {
  var condition = (typeof(element.attr('id')) !== 'undefined' &&
    typeof(box.attr('id')) !== 'undefined' &&
    element.attr('id') === box.attr('id')) ||
      element.parents('#' + box.attr('id')).length > 0;
  return condition;
}

var selectLanguage = function () {
  $('body').click(function (e) {
    var element    = $(e.target);

    if (elementIn(element, $('#chooseLanguage'))) {
      e.preventDefault();
      $('#languagesBox').slideToggle();
    }
    else if (elementIn(element, $('#languagesBox'))) {
      // do nothing
    }
    else{
      $('#languagesBox').slideUp();
    }
  });
}

$(function() {
  selectLanguage();
});