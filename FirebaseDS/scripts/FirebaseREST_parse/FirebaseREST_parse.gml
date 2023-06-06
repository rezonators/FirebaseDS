function FirebaseREST_parseArray(value) {
	
	// value should be a struct with one key: "values"
	// "values" is an array of Firebase-formatted structs, for example: {stringValue: "a"}
	
	// let's go through each of these values and make a new array that removes the Firebase formatting
	try {
		var newArr = [];
		var valuesArr = value[$ "values"];
		var valuesArrLen = array_length(valuesArr);
		for (var i = 0; i < valuesArrLen; i++) {
			
			// take current struct and determine what type it is
			var _value = valuesArr[i];
			if (!is_struct(_value)) continue;
			
			// valueKeys should be an array with only 1 value: the type (string, double, etc)
			var _valueKeys = variable_struct_get_names(_value);
			if (array_length(_valueKeys) < 1) continue;
			var _valueType = _valueKeys[0];
			
			// get the current struct's value
			var _valueValue = _value[$ _valueType];
			
			// make sure the new value is the right type
			var _newValue = _valueValue;
			if (_valueType == "stringValue") _newValue = string(_newValue);
			else if (_valueType == "integerValue" || _valueType == "doubleValue") _newValue = real(_newValue);
			else if (_valueType == "mapValue") _newValue = FirebaseREST_parseMap(_newValue);
			
			// add new value to new array
			array_push(newArr, _newValue);
		}
		
		return newArr;
	}
	catch (e) {
		show_debug_message("FirebaseREST_arrayParse, error: " + e.message);
		return [];
	}
}

function FirebaseREST_parseMap(value) {
	
	// value should be a struct with one key: "fields"
	// "fields" is a struct of Firebase-formatted structs, for example: {stringValue: "a"}
	
	// let's go through each of these fields and make a new struct that removes the Firebase formatting
	try {
		var newStruct = {};
		var fieldsStruct = value[$ "fields"];
		var fieldsKeys = variable_struct_get_names(fieldsStruct);
		var fieldsKeysLen = array_length(fieldsKeys);
		for (var i = 0; i < fieldsKeysLen; i++) {
			var _key = fieldsKeys[i];
			var _field = fieldsStruct[$ _key];
			
			// fieldKeys should be an array with only 1 value: the type (string, double, etc)
			var _fieldKeys = variable_struct_get_names(_field);
			if (array_length(_fieldKeys) < 1) continue;
			var _valueType = _fieldKeys[0];
			
			// get the current struct's value
			var _fieldValue = _field[$ _valueType];
			
			// make sure the new value is the right type
			var _newValue = _fieldValue;
			if (_valueType == "stringValue") _newValue = string(_newValue);
			else if (_valueType == "integerValue" || _valueType == "doubleValue") _newValue = real(_newValue);
			else if (_valueType == "arrayValue") _newValue = FirebaseREST_parseArray(_newValue);
			else if (_valueType == "mapValue") _newValue = FirebaseREST_parseMap(_newValue);
			
			// add new value to new struct
			newStruct[$ _key] = _newValue;
		}

		return newStruct;
	}
	catch (e) {
		show_debug_message("FirebaseREST_structParse, error: " + e.message);
		return {};
	}
	
}