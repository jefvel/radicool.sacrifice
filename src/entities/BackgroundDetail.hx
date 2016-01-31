package entities;

import flixel.FlxSprite;

/**
 * ...
 * @author jefvel
 */
class BackgroundDetail extends FlxSprite
{

	public function new(X:Float=0, Y:Float=0, ?SimpleGraphic:Dynamic) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.bakd_sheet__png, true, 30, 15);
		this.animation.add("default", [0, 1, 2, 3], 0, false);
		this.animation.play("default");
		this.animation.randomFrame();
		this.animation.pause();
	}
	
}