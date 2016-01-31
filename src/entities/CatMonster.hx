package entities;
import flixel.FlxG;

/**
 * ...
 * @author jefvel
 */
class CatMonster extends Monster
{

	public function new(X:Float=0, Y:Float=0, ?SimpleGraphic:Dynamic) 
	{
		name = "cat";
		score = 120;
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.cat__png);
		if (Math.random() > 0.5) {
			this.x = 16;
		}else {
			this.x = FlxG.width - 16 - width;
			flipX = true;
		}
	}
}