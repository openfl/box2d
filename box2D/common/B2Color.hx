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

package box2D.common;


import box2D.common.math.B2Math;


/**
* Color for debug drawing. Each value has the range [0,1].
*/

class B2Color
{

	public function new(rr:Float, gg:Float, bb:Float) {
		_r = Std.int(255 * B2Math.clamp(rr, 0.0, 1.0));
		_g = Std.int(255 * B2Math.clamp(gg, 0.0, 1.0));
		_b = Std.int(255 * B2Math.clamp(bb, 0.0, 1.0));
	}
	
	public function set(rr:Float, gg:Float, bb:Float):Void{
		_r = Std.int(255 * B2Math.clamp(rr, 0.0, 1.0));
		_g = Std.int(255 * B2Math.clamp(gg, 0.0, 1.0));
		_b = Std.int(255 * B2Math.clamp(bb, 0.0, 1.0));
	}
	
	public var r (null, set):Float;
	public var g (null, set):Float;
	public var b (null, set):Float;
	public var color (get, null):Int;
	
	// R
	private function set_r(rr:Float) : Float{
		return _r = Std.int(255 * B2Math.clamp(rr, 0.0, 1.0));
	}
	// G
	private function set_g(gg:Float) : Float{
		return _g = Std.int(255 * B2Math.clamp(gg, 0.0, 1.0));
	}
	// B
	private function set_b(bb:Float) : Float{
		return _b = Std.int(255 * B2Math.clamp(bb, 0.0, 1.0));
	}
	
	// Color
	private function get_color() : Int{
		return (_r << 16) | (_g << 8) | (_b);
	}
	
	private var _r:Int;
	private var _g:Int;
	private var _b:Int;

}