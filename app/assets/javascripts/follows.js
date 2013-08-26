// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function follows_append_mention() {
    console.log(this.field.parent('form').find('.mentions'));
    this.field.closest('form').find('.mentions').append(this.element.clone(true));
}

function follows_elementFactory(element, e) {
    var customItemTemplate = "<div class='person thumbnail span1'><img /><span /></div>";

    var template = $(customItemTemplate).find('span')
        .text('@' + e.val).end()
        .find('img')
        .attr('src', e.meta).end();
    element.append(template);
}