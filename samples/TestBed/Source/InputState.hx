package ;

import lime.ui.KeyCode;

class InputState
{
	public var mouseDown:Bool = false;
	public var mouseX:Float;
	public var mouseY:Float;
	public var keysDown:Map<KeyCode, Bool> = new Map();

    public function new() { }
}
