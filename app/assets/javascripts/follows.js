// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function follows_append_mention() {
    var id = this.element.attr('id');
    var person = this.element.clone(true).attr('id', id + '_' + $.now());
    this.field.closest('form').find('.mentions').append(person);
}

function follows_elementFactory(element, e) {
    var customItemTemplate = "<div class='person thumbnail span1'><img /><span /></div>";

    var template = $(customItemTemplate)
        .attr('id', 'person_' + e.val)
        .find('span')
        .text('@' + e.val).end()
        .find('img')
        .attr('src', e.meta).end();
    element.append(template);
}