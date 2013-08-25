// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function comment_parse_comment(e) {
    var comment = $(this).val();
    comment_grab_last_url(comment);
}

function comment_grab_last_url(text) {
    var reg = text.match(/.*\s?(https?:\/\/[^\s]+\.[a-z\.]{2,6}\/?[^\s]*)\s?.*/);
    if(reg) {
        prev_value = $('#status_url').val();
        if(reg[1] != prev_value) {
            $('#comment_url').val(reg[1]);
            comment_grab(reg[1]);
        }
    }
}

function comment_grab(url) {
    $.ajax({
	    url: '/comments/grab.js',
	    data: {uri: encodeURIComponent(url)}
    });
}

function comment_select(e) {
    var src = $('.active.item img').attr('src');
    $('#comment_image_remote_url').val(src);
}