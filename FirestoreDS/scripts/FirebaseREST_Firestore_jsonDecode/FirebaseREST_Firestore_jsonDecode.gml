//TODO? yyundefined aparently do the work correctly, Check Obj_FirebaseREST_Listener_On_firestore_document -> HTTP Event
function FirebaseREST_Firestore_jsonDecode(json_data)
{
	//fields -> Key -> stringValue,integerValue,doubleValue -> value

	if(is_undefined(json_data) or json_data == "")
		return json_stringify({yyundefined1:"yyundefined1"})
	
	try {
	
		var jsonParse = json_parse(json_data);
		
		// check parse for error field
		if (variable_struct_exists(jsonParse, "error")) {
			var errorStruct = jsonParse[$ "error"];
			if (errorStruct == 404) {
				return json_stringify({yyundefined3:"yyundefined3"});
			}
		}
		
		// make sure the parse contains "fields"
		if (!variable_struct_exists(jsonParse, "fields")) {
			return json_stringify({yyundefined4:"yyundefined4"});
		}
		
		
		var struct = {};
		var fields = jsonParse[$ "fields"];
		var keys = variable_struct_get_names(fields);
		var keysLen = array_length(keys);
		for (var i = 0; i < keysLen; i++) {
			var _key = keys[i];
			var _fieldsValue = fields[$ _key];
			var _fieldsValueKeys = variable_struct_get_names(_fieldsValue);
			if (array_length(_fieldsValueKeys) < 1) continue;
			var _fieldsValueFirstKey = _fieldsValueKeys[0];
			var _fieldsValueFirstValue = _fieldsValue[$ _fieldsValueFirstKey];
			
			// set the proper value in struct, depending on the type (arrays and maps will have to be parsed)
			if (_fieldsValueFirstKey == "stringValue") struct[$ _key] = string(_fieldsValueFirstValue);
			else if (_fieldsValueFirstKey == "doubleValue" || _fieldsValueFirstKey == "integerValue") struct[$ _key] = real(_fieldsValueFirstValue);
			else if (_fieldsValueFirstKey == "arrayValue") {
				var parsedArr = FirebaseREST_parseArray(_fieldsValueFirstValue);
				struct[$ _key] = parsedArr;
			}
			else if (_fieldsValueFirstKey == "mapValue") {
				var parsedMap = FirebaseREST_parseMap(_fieldsValueFirstValue);
				struct[$ _key] = parsedMap;
			}
		}
		
		var json = json_stringify(struct);
		return json;
	}
	catch (e) {
		// catch error with json parse
		show_debug_message("jsonParse error: " + string(e.message));
		return json_stringify({yyundefined2:"yyundefined2"});
	}
	
}