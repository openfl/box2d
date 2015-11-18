package ;

import box2D.dynamics.B2World;
import box2D.dynamics.B2DebugDraw;
import lime.ui.KeyCode;

class Global
{
	public static var game_width:UInt = 0;
	public static var game_height:UInt = 0;
	public static var world:B2World;
	public static var debugDraw:B2DebugDraw;
    
    public static var mouseDown:Bool = false;
    public static var mouseX:Float;
    public static var mouseY:Float;

    public static var keysDown:Map<KeyCode, Bool> = new Map();
}
