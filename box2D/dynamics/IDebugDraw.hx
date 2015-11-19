package box2D.dynamics;

import box2D.common.math.B2Transform;
import box2D.common.math.B2Vec2;
import box2D.common.B2Color;

interface IDebugDraw
{
	public function clear():Void;
	public function setFlags(flags:Int):Void;
	public function getFlags():Int;
	public function appendFlags(flags:Int):Void;
	public function clearFlags(flags:Int):Void;
	public function setDrawScale(drawScale:Float):Void;
	public function getDrawScale():Float;
	public function setLineThickness(lineThickness:Float):Void;
	public function getLineThickness():Float;
	public function setAlpha(alpha:Float):Void;
	public function getAlpha():Float;
	public function setFillAlpha(alpha:Float):Void;
	public function getFillAlpha():Float;
	public function setXFormScale(xformScale:Float):Void;
	public function getXFormScale():Float;
	public function drawPolygon(vertices:Array <B2Vec2>, vertexCount:Int, color:B2Color):Void;
	public function drawSolidPolygon(vertices:Array <B2Vec2>, vertexCount:Int, color:B2Color):Void;
	public function drawCircle(center:B2Vec2, radius:Float, color:B2Color):Void;
	public function drawSolidCircle(center:B2Vec2, radius:Float, axis:B2Vec2, color:B2Color):Void;
	public function drawSegment(p1:B2Vec2, p2:B2Vec2, color:B2Color):Void;
	public function drawTransform(xf:B2Transform):Void;
}
