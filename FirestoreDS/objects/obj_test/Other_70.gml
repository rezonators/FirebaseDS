// get data from async load
var asyncType = async_load[? "type"];
var asyncStatus = async_load[? "status"];
var asyncValue = async_load[? "value"];
var asyncListener = async_load[? "listener"];
if (asyncStatus != 200) {
	show_message("Firebase error: " + string(async_load[? "errorMessage"]));
	exit;
}

if (asyncListener == listener_set) {
	listener_set = -1;
	show_debug_message("listener_set callback!");
}
else if (asyncListener == listener_read) {
	listener_read = -1;
	show_debug_message("listener_read callback!");
	
	show_debug_message("asyncValue: " + string(asyncValue));
	var jsonParse = json_parse(asyncValue);
	show_debug_message("jsonParse: " + string(jsonParse));
}