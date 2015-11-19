package ;

import lime.app.Application;
import lime.ui.KeyCode;
#if (openfl || flash || nme)
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
	var test:Test;
	var tests:Array<Test> = [];
	var testNames:Array<String> = [];
	var currentIndex:Int = 0;
	#if lime_cairo var cairoGL:CairoGLStack; #end

	override public function onPreloadComplete() {
        super.onPreloadComplete();

		#if (openfl || flash || nme) 
			var debugDraw = new B2FlashDebugDraw();
			debugDraw.setSprite(flash.Lib.current); 
			Global.debugDraw = debugDraw;
		#elseif lime_cairo
			cairoGL = new CairoGLStack();
			cairoGL.setSize(window.width, window.height);
			var debugDraw = new B2CairoDebugDraw();
			debugDraw.setCairo(cairoGL.cairo); 
			Global.debugDraw = debugDraw;
		#end

		trace("PRESS SPACEBAR FOR NEXT TEST");
		trace("CLICK & PRESS 'D' TO DELETE OBJECTS");

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

		test = tests[currentIndex];
	}

	override public function update(_) if (test != null) test.Update();

	#if lime_cairo override public function render(_) cairoGL.render(); #end
	
	override public function onKeyUp(_, code, _) {
		Global.keysDown[code] = false;

		if (code == KeyCode.SPACE)
		{
			currentIndex++;
			if (currentIndex == tests.length)
			{
				currentIndex = 0;
			}
			test = tests[currentIndex];
			trace(testNames[currentIndex]);
		}
	}

	override public function onKeyDown(_, code, _) Global.keysDown[code] = true;
    override public function onMouseMove(_, x, y) {
    	Global.mouseX = x;
    	Global.mouseY = y;
    }
    override public function onMouseDown(_, x, y, button) Global.mouseDown = true;
    override public function onMouseUp(_, x, y, button) Global.mouseDown = false;
	
	function addTest(test:Test, name:String) {
		testNames.push(name);
		tests.push(test);
	}
}
