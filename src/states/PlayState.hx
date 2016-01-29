package states;

import entities.FallingGuy;
import entities.Wall;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		var playText = new FlxText(20, 20, 0, "You're now playing!");
		//playText.color = 0x111111;
		add(playText);
		
		FlxG.camera.fade(0x11111111, .33, true ,function() {
			
		});
		
		init();
	}
	
	var guy:FallingGuy;
	var leftWall:Wall;
	var rightWall:Wall;
	
	public function init() {
		guy = new FallingGuy();
		leftWall = new Wall();
		rightWall = new Wall(true);
		add(leftWall);
		add(rightWall);
		rightWall.x = 100;
		add(guy);
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
	}	
}