package states;

import entities.BackgroundDetail;
import entities.Bat;
import entities.Bottom;
import entities.CatMonster;
import entities.FaceMonster;
import entities.Gib;
import entities.Monster;
import entities.PitBg;
import entities.PitTop;
import entities.WallLooper;
import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.group.FlxSpriteGroup;
import flixel.system.FlxSound;
import flixel.tweens.FlxTween;
import haxe.Timer;
import ui.GodOVision;
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

	private var dude:FallingGuy; //Refers to the player's dude
	var dudeContainer:FlxSpriteGroup;
	
	private var rocks:FlxGroup; //A list of all the rocks
	
	var bg:PitBg;
	var bottom:Bottom;
	var top:PitTop;
	
	var walls:WallLooper;
	
	var monsters:FlxSpriteGroup;
	var deadMonsters:FlxSpriteGroup;
	var lastHitMonster:String;
	
	var sacrificePrepared = false;
	
	var pitDetails:FlxSpriteGroup;
	
	var startingScore:Int;
	
	var ui:GodOVision;
	
	
	var emitter:FlxEmitter;
	var punchSound:FlxSound;
	var pushedSound:FlxSound;
	
	override public function create():Void
	{
		super.create();
		FlxG.sound.playMusic(AssetPaths.mainmusic__wav, 0.7);
		punchSound = FlxG.sound.load(AssetPaths.punch__wav);
		pushedSound = FlxG.sound.load(AssetPaths.pushed__wav);
		rocks = new FlxGroup();
		init();
	}
	
	public function init() {
		
		gameTimer = new DtTimer();
		gameTimer.setCallback(function() {
			//TODO
		});
		
		rockTimer = new DtTimer();
		rockTimer.setCallback(spawnRockCallback);
		
		top = new PitTop();
		bottom = new Bottom();
		walls = new WallLooper();
		bg = new PitBg();
		
		dudeContainer = new FlxSpriteGroup();
		deadMonsters = new FlxSpriteGroup();
		pitDetails = new FlxSpriteGroup();
		
		for (i in 0...30) {
			var p = new BackgroundDetail();
			p.x = Math.random() * 256;
			p.y = Math.random() * Settings.PIT_DEPTH - 200 + 100;
			pitDetails.add(p);
		}
		
		monsters = new FlxSpriteGroup();
		
		for ( i in 0...Settings.BAT_COUNT) {
			var bat = new Bat();
			bat.y = Math.random() * (Settings.PIT_DEPTH - 50);
			bat.damage = 1;
			monsters.add(bat);
		}
		
		for ( i in 0...Settings.FACE_MONSTER_COUNT) {
			var bat = new FaceMonster();
			bat.y = Math.random() * (Settings.PIT_DEPTH - 50);
			monsters.add(bat);
		}
		
		for ( i in 0...Settings.CAT_COUNT) {
			var bat = new CatMonster();
			bat.y = Math.random() * (Settings.PIT_DEPTH - 180) + 100;
			monsters.add(bat);
		}
		
		add(bg);
		add(pitDetails);
		
		add(top);
		
		add(walls);
		add(dudeContainer);
		add(monsters);
		
		add(bottom);
		
		ui = new GodOVision();
		add(ui);
		
		emitter = new FlxEmitter(0, 0, 200);
		emitter.setXSpeed( -200, 200);
		emitter.setYSpeed( -500, -50);
		emitter.gravity = 900;
		emitter.bounce = 0.2;
		
		var p:FlxParticle;
		for (i in 0...(Std.int(emitter.maxSize))) {
			p = new FlxParticle();
			p.loadGraphic(AssetPaths.blood__png, false, 8, 8);
			p.visible = true;
			emitter.add(p);
			p.animation.randomFrame();
			deadMonsters.add(p);
		}
		add(emitter);
		
		Reg.score = 0;
		Reg.lives = Settings.MAX_LIVES;
		
		prepareNewSacrifice();
	}
		
	public function prepareNewSacrifice() {
		if (Reg.lives == 0) {
			FlxG.sound.music.stop();
			FlxG.camera.fade(0x630031, 1.0, false);
			Timer.delay(function() {
				FlxG.switchState(new EndState());
				FlxG.camera.fade(0x63003, .33, true);
			}, 1000);
				
			return;
		}
		
		
		FlxTween.tween(FlxG, { 
			timeScale: 1.0 
		}, 0.3);
		
		startingScore = Reg.score;
		
		Reg.health = Settings.MAX_HEALTH;
		
		Reg.combo = 0;
		lastHitMonster = "";
		
		FlxG.camera.followLerp = 1000;
		
		dude = new FallingGuy();
		dudeContainer.add(dude);
		dude.setActive();
		
		FlxTween.tween(FlxG.camera, { followLerp: 5 }, 1);
		
		top.platform.attachToPlatform(dude);
		
		Timer.delay(function(){
			sacrificePrepared = true;
		}, 300);
		
		dude.killedSignal.addOnce(dudeKilled);
	}
	
	var startTime:Float;
	public function launchOff() {
		dude.jumpOff();
		emitter.x = dude.x;
		emitter.y = dude.y;
		emitter.start(true, 0, 0, 3);
		startTime = Timer.stamp();
		pushedSound.play();
		sacrificePrepared = false;
	}
	
	public function dudeKilled() {
		Reg.lives --;
		prepareNewSacrifice();
	}
	
	function failRound() {
		Reg.score = startingScore;
		Reg.failedRoundSgn.dispatch();
	}
	
	override public function destroy():Void
	{
		super.destroy();
		Reg.failedRoundSgn.removeAll();
		Reg.comboBrokenSgn.removeAll();
	}

	override public function update():Void
	{
		FlxG.mouse.visible = false;
		gameTimer.step(Math.floor(FlxG.elapsed * settings.GAME_SPEED));
		rockTimer.step(Math.floor(FlxG.elapsed * settings.GAME_SPEED));
		
		if (sacrificePrepared) {
			if (FlxG.keys.anyJustPressed(["A", "D"]) || FlxG.touches.justStarted().length > 0) {
				launchOff();
			}
		}
		
		super.update();

		FlxG.overlap(dude, rocks, hitRock);
		
		FlxG.collide(walls.hitboxes, dude, function(a, b) {
			
		});
		
		FlxG.collide(deadMonsters, walls.hitboxes);
		FlxG.collide(deadMonsters, bottom.bottom);
		
		FlxG.collide(bottom.bottom, dude, function(a, b) {
			punchEnemy(bottom.bottom);
			dude.completelySplatter();
		});
		
		if (dude != null) {	
			dude.angularAcceleration = 0;
			if (dude.alive) {
				FlxG.collide(monsters, dude, function(bat:Monster, dude:FallingGuy) {
					punchEnemy(bat);
				});
			}
		}
		
		if (FlxG.keys.justPressed.B) {
			FlxG.debugger.visible = !FlxG.debugger.visible;
		}
	}
	
	public function punchEnemy(bat:Monster) {
		if(bat.name != "bottom") {
			punchSound.play();
			emitter.x = bat.x;
			emitter.y = bat.y;
			bat.kill();
			emitter.start(true, 2.0, 0.1, 30);
			
		} else {
			GIB();
		}
		
		var comboBroken = false;
		if (lastHitMonster != bat.name && lastHitMonster != "") {
			comboBroken = true;
			Reg.comboBrokenSgn.dispatch();
			Reg.combo = 0;
		}
		
		Reg.combo ++;
		
		lastHitMonster = bat.name;
		
		Reg.score += Std.int((Reg.combo * Reg.combo * Reg.combo + 1) * bat.score);// Std.int(Math.pow(bat.score, 1 + (Reg.combo * 0.15)));
		FlxG.camera.shake(0.01, 0.1);
		
		dude.angularAcceleration = dude.angularVelocity * 2.0;
		dude.velocity.y = -250;
		
		if(comboBroken) {
			Reg.health -= Std.int(bat.damage);
		}
		
		Reg.health -= Std.int(bat.damage);
		
		
		if (Reg.health <= 0) {
		
			
			GIB();
			
			dude.completelySplatter();
			dude.visible = false;
			
			failRound();
		}
		
		dude.animation.play("hurt", true);
	}
	
	function GIB() {
		emitter.x = dude.x + dude.width * 0.5;
		emitter.y = dude.y + dude.height * 0.8;
		emitter.start(true, 0);
		for (i in 0...Std.int(3 + Math.random() * 2)) {
			var g:Gib = new Gib();
			g.x = dude.x;
			g.y = dude.y;
			deadMonsters.add(g);
			add(g);
		}
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