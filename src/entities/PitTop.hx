package entities;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

/**
 * ...
 * @author jefvel
 */
class PitTop extends FlxSpriteGroup
{

	public var platform:SacrificalPlatform;
	var bg:FlxSprite;

	public function new() 
	{
		super();
		bg = new FlxSprite();
		bg.loadGraphic(AssetPaths.topofbrunn__png);
		bg.y = -bg.height;
		
		platform = new SacrificalPlatform();
		platform.y = - 169;
		

		
		add(bg);
		add(platform);
	}

	
	public override function update() {
		super.update();
		
	}
	
}