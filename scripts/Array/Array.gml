/**
* Array constructor
*
* @function		Array([value])
* @param		{any}		[val]			Array to move values from
*/
function Array(val=[]) constructor {
	var valueArray = val;
	if (typeof(val) != "array") or (argument_count > 1) {
		for(var i = 0; i < argument_count; i++) {
			array_push(valueArray, argument[i]);
		}
	}

	value = valueArray;

	concat = ArrayConcat;
	every = ArrayEvery;
	fill = ArrayFill;
	filter = ArrayFilter;
	find = ArrayFind;
	findIndex = ArrayFindIndex;
	//flat = ArrayFlat; Still needs implementation
	forEach = ArrayForEach;
	includes = ArrayIncludes;
	indexOf = ArrayIndexOf;
	lastIndexOf = ArrayLastIndexOf;
	join = ArrayJoin;
	map = ArrayMap;
	pop = ArrayPop;
	push = ArrayPush;
	reduce = ArrayReduce;
	reduceRight = ArrayReduceRight;
	remove = ArrayRemove;
	reverse = ArrayReverse;
	shift = ArrayShift;
	slice = ArraySlice;
	some = ArraySome;
	sort = ArraySort;
	//splice = ArraySplice; Still needs implementation
	unshift = ArrayUnshift;

	getLength = ArrayLength;
}

/**
* Returns length of Array
*
* @function		ArrayLength()
* @see			array_length
*/
function ArrayLength() {
	return array_length(self.value);
}

/**
* Joins items from another Array into this Array
*
* @function		ArrayConcat(newArray)
* @param		{Array}		newArray		Array to move values from
* @return		{self}
* @see			ArrayPush
*/
function ArrayConcat(newArray) {
	try {
		// Loop over each item in the new Array
		for (var i = 0; i < newArray.getLength(); i++) {
			
			// Push values from the new Array into this Array
			self.push(newArray.value[i]);
		}

		return self;
	} catch(err) {
		// This errors if newArray is not of type Array
		log("ArrayConcat Error, argument is not of type Array");
		log(err.message);

		return self;
	}
}

/**
* Runs a function over each item in an Array and returns true if every item passes
*
* @function		ArrayRvery(function)
* @param		{function}	func		Function to run for each element of Array
* @return		{boolean}
*/
function ArrayEvery(func) {
	for (var i = 0; i < self.getLength(); i++) {
		// Return false if function returns false
		if (!func(self.value[i])) {
			return false
		}
	}

	return true;
}

/**
* Fill each index of an Array between start and end index with a value
* Does not include end index
*
* @function		ArrayFill(value, startIndex, endIndex)
* @param		{any}		val				Value to put into each index
* @param		{real}		startI			Index to start at
* @param		{real}		endI			Index to end at (this index will not be filled)
* @return		{self}
* @see			array_set
*/
function ArrayFill(val, startI, endI) {
	for (var i = startI; i < endI; i++) {
		array_set(self.value, i, val);
	}

	return self;
}

/**
* Get new array of values that fit given filter function
* Given function should return a boolean
*
* @function		ArrayFilter(function)
* @param		{function}	func			Function to run over each element
* @return		{Array}
* @see			ArrayPush, ArrayLength
*/
function ArrayFilter(func) {
	var newArray = new Array();
	for (var i = 0; i < self.getLength(); i++) {
		// If function returns true, add value to newArray
		if (func(self.value[i])) {
			newArray.push(self.value[i]);
		}
	}

	return newArray;
}

/**
* Return the first item that passes function in Array
*
* @function		ArrayFind(function)
* @param		{function}	func			Function to run over each element
* @return		{any}
* @see			ArrayLength
*/
function ArrayFind(func) {
	for (var i = 0; i < self.getLength(); i++) {
		// If function returns true, return value
		if (func(self.value[i])) {
			return self.value[i];
		}
	}

	return noone;
}

/**
* Return the index of first item that passes function in an Array
*
* @function		ArrayFindIndex(function)
* @param		{function}	func			Function to run over each element
* @return		{real}
* @see			ArrayLength
*/
function ArrayFindIndex(func) {
	for (var i = 0; i < self.getLength(); i++) {
		// If function returns true, return index
		if (func(self.value[i])) {
			return i;
		}
	}
	
	return noone;
}

//function ArrayFlat(deep = 1) {
//	for (var i = 0; i < self.getLength(); i++) {
//		if (typeof(self.value[i]) == "array") {
//			for (var j = 0; j < deep; j++) {			
//			}
//		}
//	}
//}

/**
* Run a function for each value in an Array
*
* @function		ArrayForEach(function)
* @param		{function}	func			Function to run over each element
* @return		{self}
* @see			ArrayLength
*/
function ArrayForEach(func) {
	for (var i = 0; i < self.getLength(); i++) {
		// Run function for each item
		func(self.value[i]);
	}

	return self;
}

/**
* Returns true if given value is found in the Array
*
* @function		ArrayIncludes(value)
* @param		{any}		val				Value to check for
* @return		{boolean}
* @see			ArrayIndexOf
*/
function ArrayIncludes(val) {
	// Check if value exists
	if (self.indexOf(val) >= 0) {
		return true;
	}
	return false;
}

/**
* Returns the first index of the given value
* Returns noone (-4) if value is not found
*
* @function		ArrayIndexOf(value)
* @param		{any}		val				Value to check for
* @return		{real}
* @see			ArrayLength
*/
function ArrayIndexOf(val) {
	for (var i = 0; i < self.getLength(); i++) {
		if (self.value[i] == val) {
			return i;
		}
	}

	return noone;
}

/**
* Returns the last index of the given value
* Returns noone (-4) if value is not found
*
* @function		ArrayLastIndexOf(value)
* @param		{any}		val				Value to check for
* @return		{real}
* @see			ArrayLength
*/
function ArrayLastIndexOf(val) {
	for (var i = self.getLength() - 1; i >= 0; i--) {
		if (self.value[i] == val) {
			return i;
		}
	}

	return noone;
}

/**
* Joins values of array into a string
*
* @function		ArrayJoin([seperator])
* @param		{string}	seperator		String to append between array values
* @return		{real}
* @see			ArrayLength
*/
function ArrayJoin(seperator = "") {
	var returnString = "";
	for (var i = 0; i < self.getLength(); i++) {
		// Add current string and string of current value together
		returnString += string(self.value[i]);
		if (i != self.getLength() - 1) {
			// Add seperator to string
			returnString += seperator;
		}
	}

	return returnString;
}

/**
* Run a function for each value in the Array
* Return a new Array with the returned values
*
* @function		ArrayMap(function)
* @param		{function}	func			Function to run over each element
* @return		{Array}
* @see			ArrayLength, ArrayPush
*/
function ArrayMap(func) {
	var returnArray = new Array();
	
	for (var i = 0; i < self.getLength(); i++) {
		// Push output of function result to returnArray
		returnArray.push(func(self.value[i]));
	}
	
	return returnArray;
}

/**
* Removes the last item from the Array and returns it
*
* @function		ArrayPop()
* @return		{any}
* @see			array_pop
*/
function ArrayPop() {
	return array_pop(self.value);
}

/**
* Adds value to the end of the Array
*
* @function		ArrayPush(val, ...)
* @param		{any}		val				Values to be added to the Array
* @return		{self}
* @see			array_push
*/
function ArrayPush() {
	for(var i = 0; i < argument_count; i++) {
		array_push(self.value, argument[i]);
	}

	return self;
}

/**
* Combines all values in the Array using the provided function
*
* @function		ArrayReduce(function, [initialValue])
* @param		{function}	func			Function used to combine values (Should take 2 values)
* @param		{any}		[initialValue]	Starting value. Set to [0] if no value given
* @return		{self}
* @see			ArrayLength
*/
function ArrayReduce(func, initialValue=undefined) {
	var start = 0;

	if (initialValue == undefined) {
		// Set initialValue to first item in Array if initialValue is undefined
		initialValue = self.value[start];
		start = 1;	
	}

	var currentValue = initialValue;

	for (var i = start; i < self.getLength(); i++) {
		// Run function to combine values
		currentValue = func(currentValue, self.value[i]);
	}

	return currentValue;
}

/**
* Combines all values in the Array starting from the end using the provided function
*
* @function		ArrayReduceRight(function, [initialValue])
* @param		{function}	func			Function used to combine values (Should take 2 values)
* @param		{any}		[initialValue]	Starting value. Set to last index if no value given
* @return		{self}
* @see			ArrayLength
*/
function ArrayReduceRight(func, initialValue=undefined) {
	var start = self.getLength() - 1;

	if (initialValue == undefined) {
		// Set initialValue to last item in Array if initialValue is undefined
		initialValue = self.value[start];
		start -= 1;
	}

	var currentValue = initialValue;

	for (var i = start; i >= 0; i--) {
		// Run function to combine values
		currentValue = func(currentValue, self.value[i]);
	}

	return currentValue;
}

/**
* Remove a single value at the given index
*
* @function		ArrayRemove(index)
* @param		{real}		index			Index of value to remove
* @return		{self}
* @see			array_delete
*/
function ArrayRemove(index) {
	array_delete(self.value, index, 1);

	return self;
}

/**
* Reverse the order of the array
*
* @function		ArrayReverse()
* @return		{self}
* @see			ArrayLength, ArrayPush
*/
function ArrayReverse() {
	var newArray = new Array();

	// Loop over Array backwards
	for (var i = self.getLength() - 1; i >= 0; i--) {
		// Push values to temp newArray
		newArray.push(self.value[i]);
	}

	// Set value to newArray's value
	self.value = newArray.value;

	// Delete temporary newArray
	delete newArray;

	return self;
}

/**
* Removes and returns the first value of the Array
*
* @function		ArrayShift()
* @return		{any}
* @see			array_delete
*/
function ArrayShift() {
	var valToRemove = self.value[0];

	// Remove first value in the array
	array_delete(self.value, 0, 1);

	return valToRemove;
}

/**
* Removes values from the Array using start and end index. Returns an array of removed items
*
* @function		ArraySlice(startIndex, [endIndex])
* @param		{real}		startI			Start index to start removing items from
* @param		{real}		[endI]			Index to stop removing items at (Item at this index is not removed)
* @return		{Array}
* @see			ArrayPush, array_delete
*/
function ArraySlice(startIndex, endIndex=self.getLength()) {
	var newArray = new Array();

	for (var i = startIndex; i < endIndex; i++) {
		// Push values to be deleted to newArray
		newArray.push(self.value[i]);
	}

	// Remove all values within index range
	array_delete(self.value, startIndex, endIndex - startIndex);

	return newArray;
}

/**
* Checks if any item in the Array passes the given function
*
* @function		ArraySome(function)
* @param		{function}	func			Function to run over each element
* @return		{boolean}
* @see			ArrayLength
*/
function ArraySome(func) {
	for (var i = 0; i < self.getLength(); i++) {
		// If function returns true, return true
		if (func(self.value[i])) {
			return true;
		}
	}

	return false;
}

/**
* Sorts the Array using the sort function provided
*
* @function		ArrayMap(function)
* @param		{function}	func			Sort function
* @return		{self}
* @see			array_sort
*/
function ArraySort(func) {
	array_sort(self.value, func);

	return self;
}

/**
* Adds any number of elements to the beginning of an Array
* Returns length of the array
*
* @function		ArrayUnshift()
* @return		{real}
* @see			ArrayLength, array_insert
*/
function ArrayUnshift() {
	// Add all values to the beginning of the array
	for (var i = 0; i < argument_count; i++) {
		array_insert(self.value, i, argument[i]);
	}

	return self.getLength();
}
