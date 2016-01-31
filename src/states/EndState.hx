package states;

import flixel.effects.particles.FlxEmitter;
import flixel.effects.particles.FlxParticle;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import haxe.Http;
import haxe.Timer;

/**
 * ...
 * @author jefvel
 */
class EndState extends FlxState
{

	public function new() 
	{
		super();
	}
	
	var finished = false;
	var god:FlxSprite;
	var wellDone:FlxSprite;
	var splash:FlxSound;
	var emitter:FlxEmitter;
	
	override public function create():Void
	{
		super.create();
		postScore();
		splash = FlxG.sound.load(AssetPaths.pling__wav);
		
		var o = new FlxSprite();
		o.loadGraphic(AssetPaths.hella__png);
		o.y = FlxG.height - o.height;
		add(o);
		
		place = new FlxText(0, 0, FlxG.width);
		place.alignment = "center";
		Timer.delay(showScore, 1000);
		
		scoreText = new FlxText();
		scoreText.text = "" +Reg.score;
		
		scoreText.y = 60;
		scoreText.scale.y = scoreText.scale.x = 8;
		FlxG.timeScale = 1.0;
		
		god = new FlxSprite();
		god.loadGraphic(AssetPaths.god__png);
		god.x = FlxG.width * 0.5 - god.width * 0.5;
		wellDone = new FlxSprite();
		wellDone.loadGraphic(AssetPaths.well_done__png);
		
		emitter = new FlxEmitter(0, 0, 200);
		emitter.setXSpeed( -200, 200);
		emitter.setYSpeed( -500, -50);
		emitter.gravity = 900;
		emitter.bounce = 0.2;
		
		var p:FlxParticle;
		for (i in 0...(Std.int(emitter.maxSize))) {
			p = new FlxParticle();
			p.loadGraphic(AssetPaths.skull__png);
			p.visible = true;
			emitter.add(p);
		}
		
		add(emitter);		
	}
	
	var place:FlxText;
	
	function postScore() {
		var req = new Http("http://api.sacrifice.jefvel.net/score.php");
		req.addParameter("score", "" + Reg.score);
		req.request(true);
		
		req.onData = function(data:String) {
			place.text = "Your Sacrifice is ranked\n#" + data;
			place.x = 0;
		}
	}
	
	var t = 0.0;
	override public function update():Void 
	{
		super.update();
		t += 0.1;
		god.y = FlxG.height - god.height - 100 + Math.sin(t * 1.4) * 10;
		god.angle = Math.cos(t * 0.5) * 20;
		
		god.flipX = (Math.cos(t * 0.3) > 0);
		emitter.x = god.x + god.width * 0.5;
		emitter.y = god.y + god.health * 0.5;
		
		wellDone.x = god.x - wellDone.width;
		wellDone.y = god.y - 20;
		wellDone.angle = Math.random() * 10 - 5;
		
		FlxG.timeScale = 1.0;
		scoreText.x = (FlxG.width - scoreText.width) * 0.5;
		if (finished) {
			if (FlxG.keys.anyJustPressed(["A", "D"]) || FlxG.touches.justStarted().length > 0) {
				splash.play();
				finished = false;
				FlxG.sound.music.stop();
				FlxG.camera.fade(0x630031, .63, false, function() {
					FlxG.switchState(new MenuState());
					FlxG.camera.fade(0x63003, .33, true);
				});
			}
		}
	}
	
	var scoreText:FlxText;
	
	function showScore() {
		FlxG.sound.playMusic(AssetPaths.endmusic__wav);
		add(emitter);
		add(god);
		
		emitter.start(false, 0, 0.05);
		
		add(wellDone);
		scoreText.angle = -20 + Math.random() * 40;
		add(scoreText);
		Timer.delay(function() {
			FlxTween.tween(scoreText.scale, { x:3, y:3 }, 0.1);
			FlxTween.tween(scoreText, { angle:0 }, 0.05);
		}, 200);
		
		Timer.delay(function() {
			add(place);
			finished = true;
			place.y = scoreText.y + scoreText.height + 2;
		}, 500);
	}
}