$(function() {
    // This is a hack that shouldn't be necessary according to the docs for Bootstrap.
    // Remove if it causes problems.
    $('.dropdown-toggle').dropdown();


    $('.grab-url').load(status_grab_url);
    $('.url-container').on('keyup', status_parse_body).on('change', status_parse_body);
});