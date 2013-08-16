// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

function shares_images(e) {
    $.ajax({
	    url: '/shares/images.js',
	    data: {uri: encodeURIComponent($(this).val())}
    });
}

function shares_select(e) {
    e.preventDefault();
    var src = $(this).children('img').first().attr('src');
    $('#share_image_remote_url').val(src);
    $('#selected_image').attr('src', src);
}