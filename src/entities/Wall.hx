package entities;

import flixel.FlxSprite;

/**
 * ...
 * @author jefvel
 */
class Wall extends FlxSprite
{

	public function new(flipped:Bool = false) 
	{
		super(0, 0, null);
		if (flipped) {
			flipX = true;
		}
		loadGraphic(AssetPaths.wall__png, false, 16, 64);
	}
	
}