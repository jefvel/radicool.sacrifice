package entities;

import flixel.FlxSprite;

/**
 * ...
 * @author jefvel
 */
class FallingGuy extends FlxSprite
{

	public function new(X:Float=0, Y:Float=0, ?SimpleGraphic:Dynamic) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.falling_sheet__png, true, 32, 32);
		
		animation.add("falling", [0, 1, 2], 6, true);
		animation.play("falling");
		
	}
	
	public override function update() {
		super.update();
		animation.play("falling");
	}
}