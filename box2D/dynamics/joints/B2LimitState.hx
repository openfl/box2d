package box2D.dynamics.joints;

#if (haxe_ver >= 4.0) enum #else @:enum #end abstract B2LimitState(Int) from Int to Int
{
	var INACTIVE_LIMIT = 0;
	var AT_LOWER_LIMIT = 1;
	var AT_UPPER_LIMIT = 2;
	var EQUAL_LIMITS = 3;
}
