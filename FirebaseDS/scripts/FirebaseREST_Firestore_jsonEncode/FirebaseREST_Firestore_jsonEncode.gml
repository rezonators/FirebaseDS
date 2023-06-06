function FirebaseREST_Firestore_jsonEncode(json)
{
	// create a new struct that uses the original json as a base, but each value in the new struct will have its own sub-struct
	var structOriginal = json_parse(json);
	var structNew = {};
	
	// loop through keys in original struct and add create a new sub-struct for each value
	var keys = variable_struct_get_names(structOriginal);
	var keysLen = array_length(keys);
	for (var i = 0; i < keysLen; i++) {
		var _key = keys[i];
		var _value = structOriginal[$ _key];
		
		// get sub-struct for new value
		var _valueStruct = FirebaseREST_firestore_value(_value);
		
		// add value struct to our new struct
		structNew[$ _key] = _valueStruct;
	}
	
	var wrapper = {fields : structNew};
	var json_send = json_stringify(wrapper, true);
	return json_send;
	
}