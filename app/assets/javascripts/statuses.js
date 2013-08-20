// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function status_parse_body(e) {
	var reg = $(this).val().match(/.*\s?(https?:\/\/[^\s]+\.[a-z\.]{2,6}\/?[^\s]*)\s?.*/);
	if(reg) {
		$('#status_url').val(reg[1]);
		status_grab(reg[1]);
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

function status_dismiss_modal(e) {
	$('#modal-body').html('<div class="spinner"></div>')
}