// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function follows_append_mention() {
    var mention = this;
    var person = $('#person-' + mention.toLowerCase());
    if(person.length) {
        return;
    }
    $.ajax({
        url: '/people/' + mention + '/mini',
        success: function (data) {
            $('#mentions, #modal_mentions').append(data);
        }
    });
}

function follows_elementFactory(element, e) {
    var customItemTemplate = "<div><span />&nbsp;<img /></div>";

    var template = $(customItemTemplate).find('span')
        .text('@' + e.val).end()
        .find('img')
        .attr('src', e.meta).end();
    element.append(template);
}