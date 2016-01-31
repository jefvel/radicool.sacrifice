package entities;

import flixel.FlxSprite;

/**
 * ...
 * @author jefvel
 */
class Monster extends FlxSprite
{
	public var name:String;
	public var score:Float;
	public var damage:Float = 0;
	public var lifeSpan:Int = 100;

	public function new(X:Float=0, Y:Float=0, ?SimpleGraphic:Dynamic) 
	{
		super(X, Y, SimpleGraphic);
		
	}
	
}