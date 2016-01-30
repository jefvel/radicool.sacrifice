package entities;

import flixel.FlxSprite;

/**
 * ...
 * @author jefvel
 */
class Bottom extends FlxSprite
{

	public function new(X:Float=0, Y:Float=0, ?SimpleGraphic:Dynamic) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.bottom__png);
		this.y = Settings.PIT_DEPTH;
		this.immovable = true;
	}
	
}