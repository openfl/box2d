package box2D.dynamics;

#if (haxe_ver >= 4.0) enum #else @:enum #end abstract B2BodyType(Int) from Int to Int
{
	var STATIC_BODY = 0;
	var KINEMATIC_BODY = 1;
	var DYNAMIC_BODY = 2;
}
