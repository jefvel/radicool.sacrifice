package entities;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

/**
 * ...
 * @author jefvel
 */
class Bottom extends FlxSpriteGroup
{
	var spikes:FlxSprite;
	public var bottom:Monster;
	public function new(X:Float=0, Y:Float=0) 
	{
		super(X, Y, 0);
		
		bottom = new Monster();
		bottom.name = "bottom";
		bottom.score = 0;
		
		bottom.loadGraphic(AssetPaths.bottom__png);
		bottom.immovable = true;
		add(bottom);
		
		this.y = Settings.PIT_DEPTH;
		this.immovable = true;
		
		spikes = new FlxSprite();
		spikes.loadGraphic(AssetPaths.spike__png);
		spikes.y = -spikes.height;
		add(spikes);
		spikes.x = 40;
		
		FlxG.camera.setBounds(0, -Settings.SKY_HEIGHT, FlxG.width, this.y + bottom.height + Settings.SKY_HEIGHT);
	}
	
}