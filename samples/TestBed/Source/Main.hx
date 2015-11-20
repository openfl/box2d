package ;

import box2D.dynamics.B2DebugDrawFlag;
import box2D.dynamics.IDebugDraw;
import lime.app.Application;
import lime.ui.KeyCode;

#if (openfl || flash || nme)
import flash.Lib;
import box2D.dynamics.B2FlashDebugDraw;
#elseif lime_cairo
import box2D.dynamics.B2CairoDebugDraw;
import CairoGLStack;
#end

/**
 * ...
 * @author Najm
 * @author jsachs
 */

class Main extends Application 
{
	override public function onPreloadComplete() {
		super.onPreloadComplete();

		inputState = new InputState();

		#if (openfl || flash || nme) 
		var flashDebugDraw = new B2FlashDebugDraw();
		flashDebugDraw.setSprite(Lib.current);
		debugDraw = flashDebugDraw;
		#elseif lime_cairo
		cairoGL = new CairoGLStack();
		cairoGL.setSize(window.width, window.height);
		var cairoDebugDraw = new B2CairoDebugDraw();
		cairoDebugDraw.setCairo(cairoGL.cairo);
		debugDraw = cairoDebugDraw;
		#end

		if (debugDraw != null) {
			debugDraw.setDrawScale(30.0);
			debugDraw.setFillAlpha(0.3);
			debugDraw.setLineThickness(1.0);
			debugDraw.setFlags(B2DebugDrawFlag.Shapes | B2DebugDrawFlag.Joints);
		}

		addTest(new TestBridge(), "Bridge Test");
		addTest(new TestCCD(), "Contious Collision Detection Test");
		addTest(new TestCrankGearsPulley(), "Crank Gears Pulley Test");
		addTest(new TestRagdoll(), "Rag Doll Test");
		addTest(new TestStack(), "Stack Test");
		addTest(new TestTheoJansen(), "Theo Jansen Test");
		addTest(new TestRaycast(), "Ray Cast Test");
		addTest(new TestOneSidedPlatform(), "One Sided Platform Test");
		addTest(new TestBreakable(), "Breakable Test");
		addTest(new TestCompound(), "Compound Test");
		addTest(new TestBuoyancy(), "Buoyancy Test"); //hangs on load

		trace("PRESS SPACEBAR FOR NEXT TEST");
		trace("CLICK & PRESS 'D' TO DELETE OBJECTS");
		currentIndex = tests.length;
		showNextTest();
	}

	override public function update(milliseconds) {
		if (test != null) {
			var delta = milliseconds / 1000;
			delta = 1 / frameRate; // forces time step to be uniform; optional of course
			test.Update(delta);
		}
	}

	#if lime_cairo override public function render(_) cairoGL.render(); #end
	
	override public function onKeyUp(_, code, _) {
		inputState.keysDown[code] = false;
		if (code == KeyCode.SPACE) showNextTest();
	}

	override public function onKeyDown(_, code, _) inputState.keysDown[code] = true;
	
	override public function onMouseMove(_, x, y) {
		inputState.mouseX = x;
		inputState.mouseY = y;
	}
	
	override public function onMouseDown(_, x, y, button) inputState.mouseDown = true;
	
	override public function onMouseUp(_, x, y, button) inputState.mouseDown = false;
	
	function addTest(test:Test, name:String) {
		test.m_name = name;
		if (debugDraw != null) test.SetDebugDraw(debugDraw);
		test.m_inputState = inputState;
		tests.push(test);
	}

	function showNextTest() {
		currentIndex++;
		if (currentIndex > tests.length - 1) currentIndex = 0;
		test = tests[currentIndex];
		trace(test.m_name);
	}

	var test:Test;
	var tests:Array<Test> = [];
	var currentIndex:Int = 0;
	var inputState:InputState;
	var debugDraw:IDebugDraw;
	#if lime_cairo var cairoGL:CairoGLStack; #end
}
