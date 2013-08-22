var ajax_active = false;

function start_ajax(e) {
    ajax_active = true;
}

function stop_ajax(e) {
    ajax_active = false;
}

function ensure_ajax_inactive(e) {
    if(ajax_active) {
        return false;
    }
}

function cooperative_initialize_remote_form(e) {
    $(this).on('ajax:before', ensure_ajax_inactive);
    $(document).bind("ajaxSend", start_ajax).bind("ajaxComplete", stop_ajax);
}