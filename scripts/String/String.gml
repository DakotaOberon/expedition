/**
* String constructor
*
* @function		String([value])
* @param		{string}	val				Initial string value
*/
function String(_val="") constructor {
	value = _val;

	getLength = StringGetLength;
	at = StringAt;
	concat = StringConcat;
	contains = StringContains;
	endsWith = StringEndsWith;
	indexOf = StringIndexOf;
	lastIndexOf = StringLastIndexOf;
	repeatStr = StringRepeatStr;
	slice = StringSlice;
	split = StringSplit;
	startsWith = StringStartsWith;
	toLowerCase = StringToLowerCase;
	toUpperCase = StringToUpperCase;
	trim = StringTrim;
	trimStart = StringTrimStart;
	trimEnd = StringTrimEnd;
	titleCase = StringTitleCase;
	wonkyCase = StringWonkyCase;

	toString = function() {
		return self.value;
	}
}

/**
* Returns length of string
*
* @function		StringGetLength()
* @return		{real}
* @see			string_length
*/
function StringGetLength() {
	return string_length(self.value);
}

/**
* Returns character at given position in string
*
* @function		StringAt(index)
* @param		{real}		index			Index to retrive character
* @see			string_char_at
*/
function StringAt(_index) {
	return string_char_at(self.value, _index);
}

/**
* Adds a string to the end of the current string
*
* @function		StringConcat(string)
* @param		{string}	str				String to append
* @return		{self}
*/
function StringConcat(_str) {
	self.value = self.value + _str;
	return self;
}

/**
* Checks if the String contains the search string
*
* @function		StringContains(searchString)
* @param		{string}	searchString	String to search for
* @return		{boolean}
*/
function StringContains(searchString) {
	return sign(self.indexOf(searchString));
}

/**
* Checks if the String ends with the search string
*
* @function		StringEndsWith(searchString)
* @param		{string}	searchString	String to search for
* @return		{boolean}
* @see			StringGetLength, string_length
*/
function StringEndsWith(searchString) {
	// Grab characters from the end of the String with length of searchString
	var compareString = self.slice(1, self.getLength() - string_length(searchString));
	return (compareString == searchString);
}

/**
* Gives index of search string
*
* @function		StringIndexOf(searchString, [startPosition])
* @param		{string}	searchString	String to search for
* @param		{real}		startPosition	Index to begin search at
* @return		{real}
* @see			string_pos_ext
*/
function StringIndexOf(searchString, startPos=1) {
	return string_pos_ext(searchString, self.value, startPos);
}

/**
* Gives last index of search string
*
* @function		StringLastIndexOf(searchString, [startPosition])
* @param		{string}	searchString	String to search for
* @param		{real}		startPosition	Index to begin search at
* @return		{real}
* @see			string_last_pos_ext
*/
function StringLastIndexOf(searchString, startPos=self.getLength()) {
	return string_last_pos_ext(searchString, self.value, startPos);
}

/**
* Return a string repeated {count} number of times
*
* @function		StringRepeatStr(count)
* @param		{real}		count			Number of times to repeat string
* @return		{string}
* @see			string_repeat
*/
function StringRepeatStr(count) {
	return string_repeat(self.value, count);
}

/**
* Returns a string between startIndex and endIndex
*
* @function		StringSlice([startIndex], [endIndex])
* @param		{real}		startIndex		Start index of string
* @param		{real}		endIndex		End index of string
* @return		{string}
* @see			string_delete
*/
function StringSlice(startIndex=1, endIndex=self.getLength() + 1) {
	// Remove characters before the start index
	var firstCut = string_delete(self.value, 1, startIndex - 1);

	// Remove characters after the end index
	return string_delete(firstCut, endIndex - startIndex + 1, self.getLength() - endIndex + 1);
}

/**
* Returns an Array of sections of the String, split on {seperator}
*
* @function		StringSplit([seperator])
* @param		{real}		seperator		Which character to seperate on
* @return		{Array}
* @see			StringGetLength, StringAt, StringPush, StringSlice
*/
function StringSplit(seperator=noone) {
	var returnArray = new Array();

	if (is_string(seperator)) {
		var lastStartIndex = 1;
		for(var i = 1; i <= self.getLength(); i++) {
			if (self.at(i) == seperator) {
				returnArray.push(self.slice(lastStartIndex, i));
				lastStartIndex = i + 1;
			} else if (i == self.getLength()) {
				returnArray.push(self.slice(lastStartIndex, i + 1));
			}
		}
	} else {
		returnArray.push(self.value);
	}
	return returnArray;
}

/**
* Checks if the String starts with {searchString}
*
* @function		StringStartsWith(searchString)
* @param		{string}	searchString	Which character to seperate on
* @return		{boolean}
* @see			StringSlice
*/
function StringStartsWith(searchString) {
	// Grab characters from the beginning of the String with length of searchString
	var compareString = self.slice(1, string_length(searchString) + 1);
	return (compareString == searchString);
}

/**
* Converts the String to all lowercase characters
*
* @function		StringToLowerCase()
* @return		{string}
* @see			string_lower
*/
function StringToLowerCase() {
	return string_lower(self.value);
}

/**
* Converts the String to all uppercase characters
*
* @function		StringToUpperCase()
* @return		{string}
* @see			string_upper
*/
function StringToUpperCase() {
	return string_upper(self.value);
}

/**
* Return new string without whitespace
*
* @function		StringTrim()
* @return		{string}
* @see			string_replace_all
*/
function StringTrim() {
	var whiteSpace = new Array(" ", "\n", "\r", "\t", "\v");
	var returnString = self.value;
	for(var i = 0; i < whiteSpace.getLength(); i++) {
		// Replace all possible whitespace from the String with empty string
		returnString = string_replace_all(returnString, whiteSpace.value[i], "");
	}
	delete whiteSpace
	return returnString;
}

/**
* Return new string without whitespace at the beginning of the String
*
* @function		StringTrimStart()
* @return		{string}
* @see			StringGetLength, StringAt, StringSlice
*/
function StringTrimStart() {
	var index = 1;
	var char = self.at(index);
	// Find the index of the last whitepace at the beginning of the String
	while(char == " " && index < self.getLength()) {
		char = self.at(index);
		if (char == " ") {
			index += 1;
		}
	}
	return self.slice(index);
}

/**
* Return new string without whitespace at the end of the String
*
* @function		StringTrimEnd()
* @return		{string}
* @see			StringGetLength, StringAt, StringSlice
*/
function StringTrimEnd() {
	var index = self.getLength();
	var char = self.at(index);
	// Find the index of the first whitespace at the end of the string
	while(char == " " && index > 1) {
		char = self.at(index);
		if (char == " ") {
			index -= 1;
		}
	}
	return self.slice(1, index + 1);
}

/**
* Return new string with the first character of each word being capitalized
*
* @function		StringTitleCase()
* @return		{string}
* @see			StringSplit, ArrayLength, string_upper, string_char_at, string_delete
*/
function StringTitleCase() {
	// Split String into Array of words
	var tmpArray = self.split(" ");
	for(var i = 0; i < tmpArray.getLength(); i++) {
		// Pull first character from each word and uppercase
		var firstChar = string_upper(string_char_at(tmpArray.value[i], 1));
		
		// Lowercase the rest of the word
		var remaining = string_lower(string_delete(tmpArray.value[i], 1, 1));
		
		// Add values back together
		tmpArray.value[i] = firstChar + remaining;
	}

	// Combine values from Array back into a string
	var returnStr = tmpArray.join(" ");
	delete tmpArray;

	return returnStr;
}

/**
* Return new string with the all characters being randomly capitalized or lowercased
*
* @function		StringWonkyCase()
* @return		{string}
* @see			StringGetLength, irandom, string_upper, string_lower
*/
function StringWonkyCase() {
	var returnString = "";
	for(var i = 1; i <= self.getLength(); i++) {
		// Randomly upper or lower character
		if (irandom(1)) {
			returnString += string_upper(self.at(i));
		} else {
			returnString += string_lower(self.at(i));
		}
	}

	return returnString;
}