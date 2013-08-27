// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function status_parse_body(e) {
    var body = $(this).val();
    status_grab_last_url(body);
    status_check_mentions(body);
}

function status_grab_last_url(text) {
    var reg = text.match(/.*\s?(https?:\/\/[^\s]+\.[a-z\.]{2,6}\/?[^\s]*)\s?.*/);
    if(reg) {
        prev_value = $('#status_url').val();
        if(reg[1] != prev_value) {
            $('#status_url').val(reg[1]);
            status_grab(reg[1]);
        }
    }
}

function status_grab_url(e) {
	var url = $(this).val();
    status_grab(url);
}

function status_grab(url) {
    $.ajax({
	    url: '/statuses/grab.js',
	    data: {uri: encodeURIComponent(url)}
    });
}

function status_select(e) {
    var src = $('.active.item img').attr('src');
    $('#status_image_remote_url').val(src);
}

function status_check_mentions(text) {
    var mentions = text.match(/@[^\s\?\/,;:'"<>]+/g);
    $('#status_people').find('.person span').each(function(index){
       if($.inArray($(this).text(), mentions) == -1) {
           $(this).closest('.person').remove();
       }
    });
    var people = $('#status_people .person').get();
    for(index in people) {
        var person = $(people[index]);
        other_people = $('#status_people .person:contains(' + person.text() + ')').not('#' + person.attr('id'));
        if(other_people.length) {
            person.remove();
        }
    }
}