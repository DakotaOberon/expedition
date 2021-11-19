/**
* Status constructor
*
* @function		Status(type, [length], [strength], [direction])
* @param		{enum}		type			StatusType identifier
* @param		{real}		[length]		Length in frames status lasts
* @param		{real}		[strength]		Length in frames status lasts
* @param		{real}		[direction]		Length in frames status lasts
*/
function Status(_type, _length=60, _strength=1, _dir=0) constructor {
	type = _type;
	length = _length;
	strength = _strength;
	_direction = _dir;
}
