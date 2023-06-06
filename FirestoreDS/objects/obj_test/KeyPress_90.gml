var doc = {
	num : 16,
	str : "abc",
	sub : {
		_num : 22,
		_str : "def",
		_sub : {
			__num : 65,
			__str : "ghi",
			__sub : {
				___num : 98,
				___str : "jkl"
			}
		}
	},
}

show_debug_message("json original: " + json_stringify(doc, true));
listener_set = FirebaseFirestore("test/newdoc").Set(json_stringify(doc));