function FirebaseREST_firestore_value(value) 
{
	// https://firebase.google.com/docs/firestore/reference/rest/v1/Value
	
	// create a struct that specifies the type of value
	var struct = {};
	var type = typeof(value);
	
	if (type == "number") struct[$ "doubleValue"] = value;
	else if (type == "string") struct[$ "stringValue"] = value;
	else if (type == "array") {
		// if value is an array, create a new array and call this function for each value within the original array
		var arrayValue = [];
		var len = array_length(value);
		for (var i = 0; i < len; i++) {
			var _value = value[i];
			var _valueStruct = FirebaseREST_firestore_value(_value);
			array_push(arrayValue, _valueStruct);
		}
		// then put the new array in a wrapper struct under the field "values"
		var wrapper = {};
		wrapper[$ "values"] = arrayValue;
		struct[$ "arrayValue"] = wrapper;
	}
	else if (type == "struct") {
		// if value is an struct, create a new struct and call this function for each value within the original struct
		var structValue = {};
		var keys = variable_struct_get_names(value);
		var keysLen = array_length(keys);
		for (var i = 0; i < keysLen; i++) {
			var _key = keys[i];
			var _value = value[$ _key];
			var _valueStruct = FirebaseREST_firestore_value(_value);
			structValue[$ _key] = _valueStruct;
		}
		// then put the new struct in a wrapper struct under the field "fields"
		var wrapper = {};
		wrapper[$ "fields"] = structValue;
		struct[$ "mapValue"] = wrapper;
	}
	
	return struct;
}