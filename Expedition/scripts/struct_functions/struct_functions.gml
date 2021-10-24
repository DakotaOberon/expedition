/**
* Copy values from a struct into another struct
*
* @function		gamepad_check_any(struct, copyFrom)
* @param		{struct}	struct			Struct to copy values to
* @param		{struct}	copyFrom		Struct to copy values from
* @return		{struct}
* @see			variable_struct_get_names, variable_struct_set, array_length
*/
function struct_copy(struct, copyFrom){
	// Get key names from copyFrom struct
	var _currNames = variable_struct_get_names(copyFrom);

	// Loop over each key name
	for(var i = 0; i < array_length(_currNames); i++) {
		// Set struct values to copyFrom values
		struct[$ _currNames[i]] = copyFrom[$ _currNames[i]];
		//variable_struct_set(struct, _currNames[i], copyFrom[$ _currNames[i]]);
	}
	return struct;
}
