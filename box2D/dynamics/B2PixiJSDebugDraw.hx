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
#if pixijs
import pixi.core.graphics.Graphics;
import pixi.core.display.Container;
#end

/**
 * Implement and register this class with a b2World to provide debug drawing of physics
 * entities in your game.
 */
class B2PixiJSDebugDraw extends B2DebugDraw
{
	public function new()
	{
		super();
		m_fillAlpha = .5;
	}

	#if pixijs
	/**
	 * Set the sprite
	 */
	public function setSprite(sprite:Container):Void
	{
		m_sprite = sprite;
		m_graphics = new Graphics();
		m_sprite.addChild(m_graphics);
	}

	/**
	 * Get the sprite
	 */
	public function getSprite():Container
	{
		return m_sprite;
	}
	#end

	/**
	 * Draw a closed polygon provided in CCW order.
	 */
	override public function drawPolygon(vertices:Array<B2Vec2>, vertexCount:Int, color:B2Color):Void
	{
		#if pixijs
		m_graphics.lineStyle(m_lineThickness, color.color, m_alpha);
		m_graphics.moveTo(vertices[0].x * m_drawScale, vertices[0].y * m_drawScale);
		for (i in 1...vertexCount)
		{
			m_graphics.lineTo(vertices[i].x * m_drawScale, vertices[i].y * m_drawScale);
		}
		m_graphics.lineTo(vertices[0].x * m_drawScale, vertices[0].y * m_drawScale);
		#end
	}

	/**
	 * Draw a solid closed polygon provided in CCW order.
	 */
	override public function drawSolidPolygon(vertices:Array<B2Vec2>, vertexCount:Int, color:B2Color):Void
	{
		#if pixijs
		// fill polygon
		m_graphics.moveTo(vertices[0].x * m_drawScale, vertices[0].y * m_drawScale);
		m_graphics.beginFill(color.color, m_fillAlpha);
		for (i in 1...vertexCount)
		{
			m_graphics.lineTo(vertices[i].x * m_drawScale, vertices[i].y * m_drawScale);
		}
		m_graphics.lineTo(vertices[0].x * m_drawScale, vertices[0].y * m_drawScale);
		m_graphics.endFill();
		// draw polygon edges
		drawPolygon(vertices, vertexCount, color);
		#end
	}

	/**
	 * Draw a circle.
	 */
	override public function drawCircle(center:B2Vec2, radius:Float, color:B2Color):Void
	{
		#if pixijs
		m_graphics.lineStyle(m_lineThickness, color.color, m_alpha);
		m_graphics.drawCircle(center.x * m_drawScale, center.y * m_drawScale, radius * m_drawScale);
		#end
	}

	/**
	 * Draw a solid circle.
	 */
	override public function drawSolidCircle(center:B2Vec2, radius:Float, axis:B2Vec2, color:B2Color):Void
	{
		#if pixijs
		m_graphics.beginFill(color.color, m_fillAlpha);
		m_graphics.drawCircle(center.x * m_drawScale, center.y * m_drawScale, radius * m_drawScale);
		m_graphics.endFill();
		m_graphics.moveTo(0, 0);
		m_graphics.moveTo(center.x * m_drawScale, center.y * m_drawScale);
		m_graphics.lineStyle(m_lineThickness, color.color, m_alpha);
		m_graphics.lineTo((center.x + axis.x * radius) * m_drawScale, (center.y + axis.y * radius) * m_drawScale);
		#end
	}

	/**
	 * Draw a line segment.
	 */
	override public function drawSegment(p1:B2Vec2, p2:B2Vec2, color:B2Color):Void
	{
		#if pixijs
		m_graphics.lineStyle(m_lineThickness, color.color, m_alpha);
		m_graphics.moveTo(p1.x * m_drawScale, p1.y * m_drawScale);
		m_graphics.lineTo(p2.x * m_drawScale, p2.y * m_drawScale);
		#end
	}

	/**
	 * Draw a transform. Choose your own length scale.
	 * @param xf a transform.
	 */
	override public function drawTransform(xf:B2Transform):Void
	{
		#if pixijs
		m_graphics.moveTo(xf.position.x * m_drawScale, xf.position.y * m_drawScale);
		m_graphics.lineStyle(m_lineThickness, new B2Color(1, 0, 0).color, m_alpha);
		m_graphics.lineTo((xf.position.x + m_xformScale * xf.R.col1.x) * m_drawScale, (xf.position.y + m_xformScale * xf.R.col1.y) * m_drawScale);
		m_graphics.lineStyle(m_lineThickness, new B2Color(0, 1, 0).color, m_alpha);
		m_graphics.moveTo(xf.position.x * m_drawScale, xf.position.y * m_drawScale);
		m_graphics.lineTo((xf.position.x + m_xformScale * xf.R.col2.x) * m_drawScale, (xf.position.y + m_xformScale * xf.R.col2.y) * m_drawScale);
		#end
	}

	/**
	 * Clears debug graphics view.
	 */
	override public function clear():Void
	{
		#if pixijs
		m_graphics.clear();
		#end
	}

	#if pixijs
	public var m_sprite:Container;
	public var m_graphics:Graphics;
	#end
}
