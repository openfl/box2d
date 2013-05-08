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

package box2D.dynamics.contacts;


import box2D.collision.B2Manifold;
import box2D.collision.shapes.B2CircleShape;
import box2D.collision.shapes.B2EdgeShape;
import box2D.common.math.B2Transform;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.contacts.B2Contact;


/**
* @private
*/
class B2EdgeAndCircleContact extends B2Contact
{
	static public function create(allocator:Dynamic):B2Contact{
		return new B2EdgeAndCircleContact();
	}
	static public function destroy(contact:B2Contact, allocator:Dynamic) : Void{
		//
	}

	public override function reset(fixtureA:B2Fixture = null, fixtureB:B2Fixture = null):Void{
		super.reset(fixtureA, fixtureB);
		//b2Settings.b2Assert(m_shape1.m_type == B2ShapeType.CIRCLE_SHAPE);
		//b2Settings.b2Assert(m_shape2.m_type == B2ShapeType.CIRCLE_SHAPE);
	}
	//~b2EdgeAndCircleContact() {}
	
	public override function evaluate() : Void{
		var bA:B2Body = m_fixtureA.getBody();
		var bB:B2Body = m_fixtureB.getBody();
		b2CollideEdgeAndCircle(m_manifold,
					cast (m_fixtureA.getShape(), B2EdgeShape), bA.m_xf,
					cast (m_fixtureB.getShape(), B2CircleShape), bB.m_xf);
	}
	
	private function b2CollideEdgeAndCircle(manifold: B2Manifold,
	                                        edge: B2EdgeShape, 
	                                        xf1: B2Transform,
	                                        circle: B2CircleShape, 
	                                        xf2: B2Transform): Void
	{
		//TODO_BORIS
		/*
		manifold.m_pointCount = 0;
		var tMat: B2Mat22;
		var tVec: B2Vec2;
		var dX: Number;
		var dY: Number;
		var tX: Number;
		var tY: Number;
		var tPoint:B2ManifoldPoint;
		
		//b2Vec2 c = b2Mul(xf2, circle->GetLocalPosition());
		tMat = xf2.R;
		tVec = circle.m_r;
		var cX: Number = xf2.position.x + (tMat.col1.x * tVec.x + tMat.col2.x * tVec.y);
		var cY: Number = xf2.position.y + (tMat.col1.y * tVec.x + tMat.col2.y * tVec.y);
		
		//b2Vec2 cLocal = b2MulT(xf1, c);
		tMat = xf1.R;
		tX = cX - xf1.position.x;
		tY = cY - xf1.position.y;
		var cLocalX: Number = (tX * tMat.col1.x + tY * tMat.col1.y );
		var cLocalY: Number = (tX * tMat.col2.x + tY * tMat.col2.y );
		
		var n: B2Vec2 = edge.m_normal;
		var v1: B2Vec2 = edge.m_v1;
		var v2: B2Vec2 = edge.m_v2;
		var radius: Number = circle.m_radius;
		var separation: Number;
		
		var dirDist: Number = (cLocalX - v1.x) * edge.m_direction.x +
		                      (cLocalY - v1.y) * edge.m_direction.y;
		
		var normalCalculated: Boolean = false;
		
		if (dirDist <= 0) {
			dX = cLocalX - v1.x;
			dY = cLocalY - v1.y;
			if (dX * edge.m_cornerDir1.x + dY * edge.m_cornerDir1.y < 0) {
				return;
			}
			dX = cX - (xf1.position.x + (tMat.col1.x * v1.x + tMat.col2.x * v1.y));
			dY = cY - (xf1.position.y + (tMat.col1.y * v1.x + tMat.col2.y * v1.y));
		} else if (dirDist >= edge.m_length) {
			dX = cLocalX - v2.x;
			dY = cLocalY - v2.y;
			if (dX * edge.m_cornerDir2.x + dY * edge.m_cornerDir2.y > 0) {
				return;
			}
			dX = cX - (xf1.position.x + (tMat.col1.x * v2.x + tMat.col2.x * v2.y));
			dY = cY - (xf1.position.y + (tMat.col1.y * v2.x + tMat.col2.y * v2.y));
		} else {
			separation = (cLocalX - v1.x) * n.x + (cLocalY - v1.y) * n.y;
			if (separation > radius || separation < -radius) {
				return;
			}
			separation -= radius;
			
			//manifold.normal = b2Mul(xf1.R, n);
			tMat = xf1.R;
			manifold.normal.x = (tMat.col1.x * n.x + tMat.col2.x * n.y);
			manifold.normal.y = (tMat.col1.y * n.x + tMat.col2.y * n.y);
			
			normalCalculated = true;
		}
		
		if (!normalCalculated) {
			var distSqr: Number = dX * dX + dY * dY;
			if (distSqr > radius * radius)
			{
				return;
			}
			
			if (distSqr < Number.MIN_VALUE)
			{
				separation = -radius;
				manifold.normal.x = (tMat.col1.x * n.x + tMat.col2.x * n.y);
				manifold.normal.y = (tMat.col1.y * n.x + tMat.col2.y * n.y);
			}
			else
			{
				distSqr = Math.sqrt(distSqr);
				dX /= distSqr;
				dY /= distSqr;
				separation = distSqr - radius;
				manifold.normal.x = dX;
				manifold.normal.y = dY;
			}
		}
		
		tPoint = manifold.points[0];
		manifold.pointCount = 1;
		tPoint.id.key = 0;
		tPoint.separation = separation;
		cX = cX - radius * manifold.normal.x;
		cY = cY - radius * manifold.normal.y;
		
		tX = cX - xf1.position.x;
		tY = cY - xf1.position.y;
		tPoint.localPoint1.x = (tX * tMat.col1.x + tY * tMat.col1.y );
		tPoint.localPoint1.y = (tX * tMat.col2.x + tY * tMat.col2.y );
		
		tMat = xf2.R;
		tX = cX - xf2.position.x;
		tY = cY - xf2.position.y;
		tPoint.localPoint2.x = (tX * tMat.col1.x + tY * tMat.col1.y );
		tPoint.localPoint2.y = (tX * tMat.col2.x + tY * tMat.col2.y );
		*/
	}
}