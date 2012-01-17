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

package box2D.common.math;


/**
* A 2D column vector.
*/

class B2Vec2
{
	public function new(x_:Float=0, y_:Float=0) : Void {x=x_; y=y_;}

	public function setZero() : Void { x = 0.0; y = 0.0; }
	public function set(x_:Float=0, y_:Float=0) : Void {x=x_; y=y_;}
	public function setV(v:B2Vec2) : Void {x=v.x; y=v.y;}

	public function getNegative():B2Vec2 { return new B2Vec2(-x, -y); }
	public function negativeSelf():Void { x = -x; y = -y; }
	
	static public function make(x_:Float, y_:Float):B2Vec2
	{
		return new B2Vec2(x_, y_);
	}
	
	public function copy():B2Vec2{
		return new B2Vec2(x,y);
	}
	
	public function add(v:B2Vec2) : Void
	{
		x += v.x; y += v.y;
	}
	
	public function subtract(v:B2Vec2) : Void
	{
		x -= v.x; y -= v.y;
	}

	public function multiply(a:Float) : Void
	{
		x *= a; y *= a;
	}
	
	public function mulM(A:B2Mat22) : Void
	{
		var tX:Float = x;
		x = A.col1.x * tX + A.col2.x * y;
		y = A.col1.y * tX + A.col2.y * y;
	}
	
	public function mulTM(A:B2Mat22) : Void
	{
		var tX:Float = B2Math.dot(this, A.col1);
		y = B2Math.dot(this, A.col2);
		x = tX;
	}
	
	public function crossVF(s:Float) : Void
	{
		var tX:Float = x;
		x = s * y;
		y = -s * tX;
	}
	
	public function crossFV(s:Float) : Void
	{
		var tX:Float = x;
		x = -s * y;
		y = s * tX;
	}
	
	public function minV(b:B2Vec2) : Void
	{
		x = x < b.x ? x : b.x;
		y = y < b.y ? y : b.y;
	}
	
	public function maxV(b:B2Vec2) : Void
	{
		x = x > b.x ? x : b.x;
		y = y > b.y ? y : b.y;
	}
	
	public function abs() : Void
	{
		if (x < 0) x = -x;
		if (y < 0) y = -y;
	}

	public function length():Float
	{
		return Math.sqrt(x * x + y * y);
	}
	
	public function lengthSquared():Float
	{
		return (x * x + y * y);
	}

	public function normalize():Float
	{
		var length:Float = Math.sqrt(x * x + y * y);
		if (length < B2Math.MIN_VALUE)
		{
			return 0.0;
		}
		var invLength:Float = 1.0 / length;
		x *= invLength;
		y *= invLength;
		
		return length;
	}

	public function isValid():Bool
	{
		return B2Math.isValid(x) && B2Math.isValid(y);
	}

	public var x:Float;
	public var y:Float;
}