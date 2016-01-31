package entities;
import flixel.FlxG;
import flixel.FlxSprite;

/**
 * ...
 * @author jefvel
 */
class PitBg extends FlxSprite
{

	public function new() 
	{
		super();
		loadGraphic(AssetPaths.pitbg__png);
	}
	
	public override function draw() {
		y = Math.max(0, FlxG.camera.scroll.y);
		super.draw();
	}	
}