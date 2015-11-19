/*
* Copyright (c) 2006-2007 Erin Catto http://www.gphysics.com
*
* This software is provided 'as-is', without any express or implied
* warranty.  In no event will the authors be held liable for any damages
* arising from the use of this software.
* Permission is granted to anyone to use this software for any purpose,
* including commercial applications, and to alter it and redistribute it
* freely, subject to the following restrictions:
* 1. The origin of this software must not be misrepresented; you must not
* claim that you wrote the original software. If you use this software
* in a product, an acknowledgment in the product documentation would be
* appreciated but is not required.
* 2. Altered source versions must be plainly marked as such, and must not be
* misrepresented as being the original software.
* 3. This notice may not be removed or altered from any source distribution.
*/

package box2D.dynamics;


import box2D.common.math.B2Transform;
import box2D.common.math.B2Vec2;
import box2D.common.B2Color;

#if lime_cairo
import lime.graphics.cairo.Cairo;
import lime.graphics.cairo.CairoOperator;
#end


/**
* Implement and register this class with a b2World to provide debug drawing of physics
* entities in your game.
*/
class B2CairoDebugDraw implements IDebugDraw
{

	public function new () {
		
		m_drawScale = 1.0;
		
		m_lineThickness = 1.0;
		m_alpha = 1.0;
		m_fillAlpha = 1.0;
		m_xformScale = 1.0;
		
		
		m_drawFlags = 0;
	}

	public function clear() {
		#if lime_cairo
		m_cairo.save();
		m_cairo.setSourceRGBA(1, 1, 1, 1);
		m_cairo.operator = CairoOperator.SOURCE;
		m_cairo.paint();
		m_cairo.restore();
		#end
	}

	/**
	* Set the drawing flags.
	*/
	public function setFlags(flags:Int) : Void{
		m_drawFlags = flags;
	}

	/**
	* Get the drawing flags.
	*/
	public function getFlags() : Int{
		return m_drawFlags;
	}
	
	/**
	* Append flags to the current flags.
	*/
	public function appendFlags(flags:Int) : Void{
		m_drawFlags |= flags;
	}

	/**
	* Clear flags from the current flags.
	*/
	public function clearFlags(flags:Int) : Void {
		m_drawFlags &= ~flags;
	}

	#if lime_cairo
	/**
	* Set the cairo
	*/
	public function setCairo(cairo:Cairo) : Void {
		m_cairo = cairo; 
	}
	
	/**
	* Get the cairo
	*/
	public function getCairo() : Cairo {
		return m_cairo;
	}
	#end
	
	/**
	* Set the draw scale
	*/
	public function setDrawScale(drawScale:Float) : Void {
		m_drawScale = drawScale; 
	}
	
	/**
	* Get the draw
	*/
	public function getDrawScale() : Float {
		return m_drawScale;
	}
	
	/**
	* Set the line thickness
	*/
	public function setLineThickness(lineThickness:Float) : Void {
		m_lineThickness = lineThickness; 
	}
	
	/**
	* Get the line thickness
	*/
	public function getLineThickness() : Float {
		return m_lineThickness;
	}
	
	/**
	* Set the alpha value used for lines
	*/
	public function setAlpha(alpha:Float) : Void {
		m_alpha = alpha; 
	}
	
	/**
	* Get the alpha value used for lines
	*/
	public function getAlpha() : Float {
		return m_alpha;
	}
	
	/**
	* Set the alpha value used for fills
	*/
	public function setFillAlpha(alpha:Float) : Void {
		m_fillAlpha = alpha; 
	}
	
	/**
	* Get the alpha value used for fills
	*/
	public function getFillAlpha() : Float {
		return m_fillAlpha;
	}
	
	/**
	* Set the scale used for drawing XForms
	*/
	public function setXFormScale(xformScale:Float) : Void {
		m_xformScale = xformScale; 
	}
	
	/**
	* Get the scale used for drawing XForms
	*/
	public function getXFormScale() : Float {
		return m_xformScale;
	}
	
	/**
	* Draw a closed polygon provided in CCW order.
	*/
	public function drawPolygon(vertices:Array <B2Vec2>, vertexCount:Int, color:B2Color) : Void{
		
		#if lime_cairo
		m_cairo.moveTo(vertices[0].x * m_drawScale, vertices[0].y * m_drawScale);
		for (i in 1...vertexCount){
				m_cairo.lineTo(vertices[i].x * m_drawScale, vertices[i].y * m_drawScale);
		}
		m_cairo.lineTo(vertices[0].x * m_drawScale, vertices[0].y * m_drawScale);
		style(m_lineThickness, color.color, m_alpha);
		m_cairo.stroke();
		#end
		
	}

	/**
	* Draw a solid closed polygon provided in CCW order.
	*/
	public function drawSolidPolygon(vertices:Array <B2Vec2>, vertexCount:Int, color:B2Color) : Void{
		
		#if lime_cairo
		m_cairo.moveTo(vertices[0].x * m_drawScale, vertices[0].y * m_drawScale);
		for (i in 1...vertexCount){
				m_cairo.lineTo(vertices[i].x * m_drawScale, vertices[i].y * m_drawScale);
		}
		m_cairo.lineTo(vertices[0].x * m_drawScale, vertices[0].y * m_drawScale);
		style(m_lineThickness, color.color, m_fillAlpha);
		m_cairo.fillPreserve();
		style(m_lineThickness, color.color, m_alpha);
		m_cairo.stroke();
		#end
		
	}

	/**
	* Draw a circle.
	*/
	public function drawCircle(center:B2Vec2, radius:Float, color:B2Color) : Void{
		
		#if lime_cairo
		constructCircle(center.x * m_drawScale, center.y * m_drawScale, radius * m_drawScale);
		style(m_lineThickness, color.color, m_alpha);
		m_cairo.stroke();
		#end
		
	}
	
	/**
	* Draw a solid circle.
	*/
	public function drawSolidCircle(center:B2Vec2, radius:Float, axis:B2Vec2, color:B2Color) : Void{
		
		#if lime_cairo
		m_cairo.moveTo(0,0);
		constructCircle(center.x * m_drawScale, center.y * m_drawScale, radius * m_drawScale);
		style(m_lineThickness, color.color, m_fillAlpha);
		m_cairo.fillPreserve();
		style(m_lineThickness, color.color, m_alpha);
		m_cairo.stroke();
		m_cairo.moveTo(center.x * m_drawScale, center.y * m_drawScale);
		m_cairo.lineTo((center.x + axis.x * radius) * m_drawScale, (center.y + axis.y * radius) * m_drawScale);
		m_cairo.stroke();
		#end
		
	}

	
	/**
	* Draw a line segment.
	*/
	public function drawSegment(p1:B2Vec2, p2:B2Vec2, color:B2Color) : Void{
		
		#if lime_cairo
		m_cairo.moveTo(p1.x * m_drawScale, p1.y * m_drawScale);
		m_cairo.lineTo(p2.x * m_drawScale, p2.y * m_drawScale);
		style(m_lineThickness, color.color, m_alpha);
		m_cairo.stroke();
		#end
		
	}

	/**
	* Draw a transform. Choose your own length scale.
	* @param xf a transform.
	*/
	public function drawTransform(xf:B2Transform) : Void{
		
		#if lime_cairo
		m_cairo.moveTo(xf.position.x * m_drawScale, xf.position.y * m_drawScale);
		m_cairo.lineTo((xf.position.x + m_xformScale*xf.R.col1.x) * m_drawScale, (xf.position.y + m_xformScale*xf.R.col1.y) * m_drawScale);
		style(m_lineThickness, 0xff0000, m_alpha);
		m_cairo.stroke();
		
		m_cairo.moveTo(xf.position.x * m_drawScale, xf.position.y * m_drawScale);
		m_cairo.lineTo((xf.position.x + m_xformScale * xf.R.col2.x) * m_drawScale, (xf.position.y + m_xformScale * xf.R.col2.y) * m_drawScale);
		style(m_lineThickness, 0x00ff00, m_alpha);
		m_cairo.stroke();
		#end
		
	}
	
	inline static var c = 0.55;
	function constructCircle(x:Float, y:Float, rad:Float) {
		m_cairo.moveTo (x + 0 * rad, y + 1 * rad);
		m_cairo.curveTo(x + c * rad, y + 1 * rad, x + 1 * rad, y + c * rad, x + 1 * rad, y + 0 * rad);
		m_cairo.curveTo(x + 1 * rad, y - c * rad, x + c * rad, y - 1 * rad, x + 0 * rad, y - 1 * rad);
		m_cairo.curveTo(x - c * rad, y - 1 * rad, x - 1 * rad, y - c * rad, x - 1 * rad, y + 0 * rad);
		m_cairo.curveTo(x - 1 * rad, y + c * rad, x - c * rad, y + 1 * rad, x + 0 * rad, y + 1 * rad);
	}

	function style(lineThickness, color, alpha) {
		m_cairo.lineWidth = lineThickness;
		var r = ((color >> 16) & 0xFF) / 0xFF;
		var g = ((color >>  8) & 0xFF) / 0xFF;
		var b = ((color >>  0) & 0xFF) / 0xFF;
		m_cairo.setSourceRGBA(r, g, b, alpha);
	}
	
	private var m_drawFlags:Int;
	#if lime_cairo
	public var m_cairo:Cairo;
	#end
	private var m_drawScale:Float;
	
	private var m_lineThickness:Float;
	private var m_alpha:Float;
	private var m_fillAlpha:Float;
	private var m_xformScale:Float;
	
}
