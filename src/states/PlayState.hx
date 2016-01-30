package states;

import util.DtTimer;
import ui.UI;
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

typedef GameSettings = {
	var GAME_DURATION:Int;
	var GAME_SPEED:Int;
	var GAME_SPAWN_RATE:Int;
}

typedef GameValues = {
	var scoreCount:Int;
}
	
class PlayState extends FlxState
{
	private var settings:GameSettings = {
		GAME_DURATION: 100 * 1000,
		GAME_SPEED: 1,
		GAME_SPAWN_RATE: 1
	};

	public static var gameValues:GameValues = {
		scoreCount: 0
	};
	
	private var gameTimer:DtTimer;
	private var rockTimer:DtTimer; //A timer to decide when to spawn next rock
	private var ui:UI; //Game UI (Score/Timers/Related images)
	
	private var dude:FallingGuy; //Refers to the player's dude
	private var rocks:FlxGroup; //A list of all the rocks
	var leftWall:Wall;
	var rightWall:Wall;
	
	override public function create():Void
	{
		super.create();
		rocks = new FlxGroup();
		
		FlxG.camera.fade(0x11111111, .33, true);
		init();
	}
	
	
	
	public function init() {
		gameTimer = new DtTimer();
		gameTimer.setCallback(function() {
			//TODO
		});
		rockTimer = new DtTimer();
		rockTimer.setCallback(spawnRockCallback);
		
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
	
	
	override public function destroy():Void
	{
		super.destroy();
	}

	override public function update():Void
	{
		
		gameTimer.step(Math.floor(FlxG.elapsed * settings.GAME_SPEED));
		rockTimer.step(Math.floor(FlxG.elapsed * settings.GAME_SPEED));
		ui.updateCountdown(gameTimer.getCountdownMs());
		
		super.update();
		Reg.depth += 2;
		FlxG.overlap(dude, rocks, hitRock);
	}
	
	private function hitRock(dude:FlxObject, rock:FlxObject):Void
	{
		rock.kill();
	}
	
	private function spawnRockCallback():Void
	{
		rockTimer = new DtTimer();
		rockTimer.setCallback(spawnRockCallback);
		rockTimer.startWithCountdownMs(settings.GAME_SPAWN_RATE);
	}
}