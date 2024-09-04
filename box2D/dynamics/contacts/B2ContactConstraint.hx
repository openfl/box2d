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
import box2D.collision.B2ManifoldType;
import box2D.common.B2Settings;
import box2D.common.math.B2Mat22;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;

/**
 * @private
 */
class B2ContactConstraint
{
	public function new()
	{
		localPlaneNormal = new B2Vec2();
		localPoint = new B2Vec2();
		normal = new B2Vec2();
		normalMass = new B2Mat22();
		K = new B2Mat22();
		points = new Array<B2ContactConstraintPoint>();
		for (i in 0...B2Settings.b2_maxManifoldPoints)
		{
			points[i] = new B2ContactConstraintPoint();
		}
	}

	public var points:Array<B2ContactConstraintPoint>;
	public var localPlaneNormal:B2Vec2;
	public var localPoint:B2Vec2;
	public var normal:B2Vec2;
	public var normalMass:B2Mat22;
	public var K:B2Mat22;
	public var bodyA:B2Body;
	public var bodyB:B2Body;
	public var type:B2ManifoldType; // b2Manifold::Type
	public var radius:Float = 0;
	public var friction:Float = 0;
	public var restitution:Float = 0;
	public var restitutionThreshold:Float = 0;
	public var pointCount:Int = 0;
	public var manifold:B2Manifold;
}
