/**
* Gets a value from {origin} to {goal} moved by {amount}
*
* @function		approach(origin, goal, amount)
* @param		{real}		origin			Starting value
* @param		{real}		goal			End goal value
* @param		{real}		amount			Amount to move value by
* @return		{real}
*/
function approach(origin, goal, amount) {
	// Ensure amount is a positive value
	amount = abs(amount);

	// See if need to add or subtract
	var multiplier = sign(goal - origin);

	// Set return value
	var returnVal = origin + (multiplier * amount);

	// If return value passed goal, set to goal
	if (abs(goal - returnVal) < amount) {
		// Set returnVal to "to" if close
		returnVal = goal;
	}

	return returnVal;
}
