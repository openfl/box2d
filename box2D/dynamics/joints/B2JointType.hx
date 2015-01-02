package box2D.dynamics.joints;


@:enum abstract B2JointType(Int) from Int to Int {
	
	var UNKNOWN_JOINT = 0;
	var REVOLUTE_JOINT = 1;
	var PRISMATIC_JOINT = 2;
	var DISTANCE_JOINT = 3;
	var PULLEY_JOINT = 4;
	var MOUSE_JOINT = 5;
	var GEAR_JOINT = 6;
	var LINE_JOINT = 7;
	var WELD_JOINT = 8;
	var FRICTION_JOINT = 9;
	
}