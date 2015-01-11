package ;
import flash.text.TextField;
import box2D.dynamics.B2World;
import flash.display.Sprite;

/**
 * ...
 * @author Najm
 */

class Global
{
	public static var game_width:UInt = 0;
	public static var game_height:UInt = 0;
	
	public static var world:B2World;
	
	public static var world_sprite:Sprite;
	
	public static var caption:TextField = new TextField();
	
	public function new() 
	{

	}	
	

}