package box2D.dynamics;


@:enum abstract B2BodyType(Int) from Int to Int {
	
	var STATIC_BODY = 0;
	var KINEMATIC_BODY = 1;
	var DYNAMIC_BODY = 2;
	
}