/**
* Instance constructor
*
* @function		Instance(index)
* @param		{real}		index			Object instance index
*/
function Instance(_index) constructor {
	value = _index;

	entries = InstanceEntries;
}

/**
* Returns an array of key, value pairs [[key, value], [key, value]]
*
* @function		InstanceEntries([_id])
* @param		{id}		[_id]			id of object
* @return		{array}
*/
function InstanceEntries(_id=self.value.id) {
	var returnArray = new Array();
	
	// Get all variable names from the object
	var keys = variable_instance_get_names(_id);

	for(var i = 0; i < array_length(keys); i++) {
		// Push [key, value] pairs into returnArray
		returnArray.push([keys[i], variable_instance_get(_id, keys[i])]);
	}

	return returnArray;
}
