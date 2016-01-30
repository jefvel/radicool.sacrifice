package entities;

import flixel.FlxG;
import flixel.FlxSprite;

/**
 * ...
 * @author jefvel
 */
class Wall extends FlxSprite
{

	public var flipped:Bool;
	public function new(flipped:Bool = false) 
	{
		super(0, 0, null);
		
		updateStuff();
		this.flipped = flipped;
		if (flipped) {
			flipX = true;
			x = FlxG.width - width;
		}
		
		this.immovable = true;
	}
	
	public function updateStuff() {
		loadGraphic(AssetPaths.wall__png, false, 16, 64);
	}
	
	public override function update() {
		super.update();
	}
}