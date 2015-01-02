package box2D.dynamics.joints;


@:enum abstract B2LimitState(Int) from Int to Int {
	
	var INACTIVE_LIMIT = 0;
	var AT_LOWER_LIMIT = 1;
	var AT_UPPER_LIMIT = 2;
	var EQUAL_LIMITS = 3;
	
}
