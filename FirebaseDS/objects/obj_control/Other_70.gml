// get attributes from async load
var asyncType = async_load[? "type"];
var asyncStatus = async_load[? "status"];
var asyncValue = async_load[? "value"];
var asyncListener = async_load[? "listener"];
var asyncErrorMessage = async_load[? "errorMessage"];

show_debug_message("asyncType: " + string(asyncType));

// check if request was successful, show error if not
if (asyncStatus != 200) {
	show_message("Firebase error: " + string(asyncErrorMessage));
	
	// reset listeners in case of error
	if (asyncListener == listener_read) listener_read = -1;
	else if (asyncListener == listener_set) listener_set = -1;
	exit;
}

// callback for read
if (asyncListener == listener_read && asyncType == FIRESTORE_DOCREAD) {
	listener_read = -1;
	show_debug_message("Read successful!");
	var doc = json_parse(asyncValue);
	show_message("Read successful:\n" + json_stringify(doc, true));
}
// callback for set
else if (asyncListener == listener_set && asyncType == FIRESTORE_DOCSET) {
	listener_set = -1;
	show_debug_message("Set successful!");
	show_message("Set successful!");
}