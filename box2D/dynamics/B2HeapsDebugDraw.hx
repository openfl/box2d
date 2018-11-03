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

#if heaps
import h2d.Graphics;
#end


/**
* Implement and register this class with a b2World to provide debug drawing of physics
* entities in your game.
*/
class B2HeapsDebugDraw extends B2DebugDraw
{

	public function new () {
		
		super();
	}

	#if heaps
	/**
	* Set the sprite
	*/
	public function setSprite(sprite:h2d.Graphics) : Void {
		m_sprite = sprite; 
	}
	
	/**
	* Get the sprite
	*/
	public function getSprite() : h2d.Graphics {
		return m_sprite;
	}
	#end
	
	/**
	* Draw a closed polygon provided in CCW order.
	*/
	override public function drawPolygon(vertices:Array <B2Vec2>, vertexCount:Int, color:B2Color) : Void{
		
		#if heaps
        m_sprite.lineStyle(m_lineThickness, color.color, m_alpha);
		m_sprite.moveTo(vertices[0].x * m_drawScale, vertices[0].y * m_drawScale);
		for (i in 1...vertexCount){
				m_sprite.lineTo(vertices[i].x * m_drawScale, vertices[i].y * m_drawScale);
		}
		m_sprite.lineTo(vertices[0].x * m_drawScale, vertices[0].y * m_drawScale);
		#end
		
	}

	/**
	* Draw a solid closed polygon provided in CCW order.
	*/
	override public function drawSolidPolygon(vertices:Array <B2Vec2>, vertexCount:Int, color:B2Color) : Void{
		
		#if heaps
        // fill polygon
        m_sprite.moveTo(vertices[0].x * m_drawScale, vertices[0].y * m_drawScale);
		m_sprite.beginFill(color.color, m_fillAlpha);
		for (i in 1...vertexCount){
				m_sprite.lineTo(vertices[i].x * m_drawScale, vertices[i].y * m_drawScale);
		}
		m_sprite.lineTo(vertices[0].x * m_drawScale, vertices[0].y * m_drawScale);
		m_sprite.endFill();

        // draw polygon edges
        drawPolygon(vertices, vertexCount, color);
		#end
		
	}

	/**
	* Draw a circle.
	*/
	override public function drawCircle(center:B2Vec2, radius:Float, color:B2Color) : Void{
		
		#if heaps
        m_sprite.lineStyle(m_lineThickness, color.color, m_alpha);
		m_sprite.drawCircle(center.x * m_drawScale, center.y * m_drawScale, radius * m_drawScale, 12);
		#end
		
	}
	
	/**
	* Draw a solid circle.
	*/
	override public function drawSolidCircle(center:B2Vec2, radius:Float, axis:B2Vec2, color:B2Color) : Void{
		
		#if heaps
		m_sprite.beginFill(color.color, m_fillAlpha);
		m_sprite.drawCircle(center.x * m_drawScale, center.y * m_drawScale, radius * m_drawScale, 12);
		m_sprite.endFill();
        m_sprite.lineStyle(m_lineThickness, color.color, m_alpha);
		m_sprite.moveTo(0,0);
		m_sprite.moveTo(center.x * m_drawScale, center.y * m_drawScale);
		m_sprite.lineTo((center.x + axis.x * radius) * m_drawScale, (center.y + axis.y * radius) * m_drawScale);
		#end
		
	}

	
	/**
	* Draw a line segment.
	*/
	override public function drawSegment(p1:B2Vec2, p2:B2Vec2, color:B2Color) : Void{
		
		#if heaps
		m_sprite.lineStyle(m_lineThickness, color.color, m_alpha);
		m_sprite.moveTo(p1.x * m_drawScale, p1.y * m_drawScale);
		m_sprite.lineTo(p2.x * m_drawScale, p2.y * m_drawScale);
		#end
		
	}

	/**
	* Draw a transform. Choose your own length scale.
	* @param xf a transform.
	*/
	override public function drawTransform(xf:B2Transform) : Void{
		
		#if heaps
		m_sprite.lineStyle(m_lineThickness, 0xff0000, m_alpha);
        m_sprite.moveTo(xf.position.x * m_drawScale, xf.position.y * m_drawScale);
		m_sprite.lineTo((xf.position.x + m_xformScale*xf.R.col1.x) * m_drawScale, (xf.position.y + m_xformScale*xf.R.col1.y) * m_drawScale);
		
		m_sprite.lineStyle(m_lineThickness, 0x00ff00, m_alpha);
		m_sprite.moveTo(xf.position.x * m_drawScale, xf.position.y * m_drawScale);
		m_sprite.lineTo((xf.position.x + m_xformScale * xf.R.col2.x) * m_drawScale, (xf.position.y + m_xformScale * xf.R.col2.y) * m_drawScale);
		#end
		
	}

	/**
	 * Clears debug graphics view.
	 */
	override public function clear():Void {

		#if heaps
		m_sprite.clear();
		#end

	}
	

	#if heaps
	public var m_sprite:h2d.Graphics;
	#end
	
}