package states;

import entities.FallingGuy;
import entities.Wall;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	public var dude:FallingGuy; //Refers to the player's dude
	public var rocks:FlxGroup; //A list of all the rocks
	public var timer:Float; //A timer to decide when to spawn next rock
	public var speedMultiplier:Float = 1; //Game speed
	public var spawnMultiplier:Float = 2; //Frequency of rock spawning
	var leftWall:Wall;
	var rightWall:Wall;
	
	
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		rocks = new FlxGroup();
		
		FlxG.camera.fade(0x11111111, .33, true);
		init();
	}
	
	
	
	public function init() {
		dude = new FallingGuy();
		dude.x = 50;
		leftWall = new Wall();
		rightWall = new Wall(true);
		add(leftWall);
		add(rightWall);
		rightWall.x = FlxG.width - rightWall.width;
		add(dude);
		Reg.depth = 0;
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

		timer -= FlxG.elapsed * speedMultiplier;
		if(timer <= 0)
				spawnRock();
				
		super.update();
		Reg.depth += 2;
		FlxG.overlap(dude, rocks, hitRock);
	}
	
	private function hitRock(dude:FlxObject, rock:FlxObject):Void
	{
		rock.kill();
	}
	
	//This function resets the timer and adds a new rock to the game
	private function spawnRock():Void
	{
		timer = 1+Math.random()*spawnMultiplier;	//Reset the timer
	}
}