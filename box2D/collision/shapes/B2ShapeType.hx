package box2D.collision.shapes;


@:enum abstract B2ShapeType(Int) from Int to Int {

	var UNKNOWN_SHAPE = 0;
	var CIRCLE_SHAPE = 1;
	var POLYGON_SHAPE = 2;
	var EDGE_SHAPE = 3;
	
}

//static public var e_circleShape:Int = 	0;
//static public var e_polygonShape:Int = 	1;
//static public var e_edgeShape:Int =       2;
//static public var e_shapeTypeCount:Int = 	3;