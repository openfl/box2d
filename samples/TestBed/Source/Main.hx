package ;
import box2D.dynamics.B2DebugDraw;


import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.KeyboardEvent;
import flash.Lib;
import openfl.display.Sprite;
import openfl.display.FPS;
import openfl.text.TextField;

/**
 * ...
 * @author Najm
 */

class Main extends Sprite 
{
	var inited:Bool;

	/* ENTRY POINT */
	
	function resize(e) 
	{
		if (!inited) init();
		// else (resize or orientation change)
	}
	
	function onEnterFrame(e:Event)
	{
		test.Update();

		if(Input.lastKey==32/*spacebar*/)
			{
				Input.lastKey = 0;
				cur_test_ind++;
				if (cur_test_ind==test_list.length)
				{
					cur_test_ind = 0;
				}

				test = test_list[cur_test_ind];
				Global.caption.text = test_name[cur_test_ind].toString();
			}

	}
	
	var pressed_count:UInt = 0;
	var test:Dynamic;
	var test_list:Array<Dynamic> = new Array();
	var test_name:Array<String> = new Array();
	var cur_test_ind:Int = 0;
	
	function init() 
	{
		if (inited) return;
		inited = true;
		
 		Global.game_width = stage.stageWidth;
 		Global.game_height = stage.stageHeight;
		
		Global.world_sprite = this;
		
		// set caption
		Global.caption.y = 10;
		Global.caption.x = 200;
		Global.caption.width = 300;
		
		addChild(Global.caption);
		
		var next_test_caption:TextField = new TextField();
		next_test_caption.y = 50;
		next_test_caption.x = 10;
		next_test_caption.width = 300;
		next_test_caption.text = "PRESS SPACEBAR FOR NEXT TEST";
		addChild(next_test_caption);
		
		var del_object_caption:TextField = new TextField();
		del_object_caption.y = 70;
		del_object_caption.x = 10;
		del_object_caption.width = 300;
		del_object_caption.text = "CLICK & PRESS 'D' TO DELETE OBJECTS";
		addChild(del_object_caption);
		
		// show frame per second
		addChild(new FPS());
		
		// take care of mouse & keyboard event
		var input:Input = new Input(this);
		
 		test_list.push(new TestBridge());
		test_name.push("Bridge Test");
		
 		test_list.push(new TestCCD());
		test_name.push("Contious Collision Detection Test");
		
 		test_list.push(new TestCrankGearsPulley());
		test_name.push("Crank Gears Pulley Test");
		
 		test_list.push(new TestRagdoll());
		test_name.push("Rag Doll Test");
		
 		test_list.push(new TestStack());
		test_name.push("Stack Test");
		
 		test_list.push(new TestTheoJansen());
		test_name.push("Theo Jansen Test");
		
		test_list.push(new TestRaycast());
		test_name.push("Ray Cast Test");
		
		test_list.push(new TestOneSidedPlatform());
		test_name.push("One Sided Platform Test");
		
		test_list.push(new TestBreakable());
		test_name.push("Breakable Test");
		
		test_list.push(new TestCompound());
		test_name.push("Compound Test");
		
 		test_list.push(new TestBuoyancy()); //hangs on load
		test_name.push("Buoyancy Test");
		
		// show 1st example
		test = test_list[test_list.length-1];
		
		addEventListener(Event.ENTER_FRAME,onEnterFrame);
		// Stage:
		// stage.stageWidth x stage.stageHeight @ stage.dpiScale
		
		// Assets:
		// nme.Assets.getBitmapData("img/assetname.jpg");
	}
	

	/* SETUP */

	public function new() 
	{
		super();	
		addEventListener(Event.ADDED_TO_STAGE, added);
	}

	function added(e) 
	{
		removeEventListener(Event.ADDED_TO_STAGE, added);
		stage.addEventListener(Event.RESIZE, resize);
		#if ios
		haxe.Timer.delay(init, 100); // iOS 6
		#else
		init();
		#end
	}
	
	public static function main() 
	{
		// static entry point
		Lib.current.stage.align = flash.display.StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = flash.display.StageScaleMode.NO_SCALE;
		Lib.current.addChild(new Main());
	}
}
