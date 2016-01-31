package ui;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import haxe.Timer;

/**
 * ...
 * @author jefvel
 */
class GodOVision extends FlxSpriteGroup
{
	var scoreText:FlxText;
	var curScore:Int;
	var comboText:FlxText;
	
	var bar:FlxSprite;
	var barbg:FlxSprite;
	
	var god:FlxSprite;
	var talking = false;
	
	var iLikeItCaption:FlxSprite;
	var coolCaption:FlxSprite;
	var radCaption:FlxSprite;
	var okCaption:FlxSprite;
	
	var lifeSprites:Array<FlxSprite>;
	var happyTalk:FlxSound;
	
	
	public function new() 
	{
		super();
		happyTalk = FlxG.sound.load(AssetPaths.happytalk__wav);
		
		this.scrollFactor.y = 0;
		scoreText = new FlxText(20, 10, 0, "Score");
		comboText = new FlxText(10, 10, 100, "");
		add(comboText);
		add(scoreText);
		
		curScore = 0;
		
		Reg.comboBrokenSgn.add(comboBroken);
		
		bar = new FlxSprite();
		bar.loadGraphic(AssetPaths.bloodbar__png);
		bar.y = FlxG.height - bar.height - 2;
		
		barbg = new FlxSprite();
		barbg.loadGraphic(AssetPaths.bloodbg__png);
		barbg.x = 22;
		barbg.y = bar.y + 2;
		barbg.origin.x = 0;
		add(barbg);
		add(bar);
		
		god = new FlxSprite();
		god.loadGraphic(AssetPaths.god__png);
		
		god.x = FlxG.width - god.width;
		god.y = FlxG.height;
		add(god);
		
		coolCaption = new FlxSprite();
		coolCaption.loadGraphic(AssetPaths.cool_bubble__png);
		
		radCaption = new FlxSprite();
		radCaption.loadGraphic(AssetPaths.rad_bubble__png);
		
		okCaption = new FlxSprite();
		okCaption.loadGraphic(AssetPaths.ok_bubble__png);
		
		iLikeItCaption = new FlxSprite();
		iLikeItCaption.loadGraphic(AssetPaths.i_like_it_bubble__png);
		
		lifeSprites = new Array<FlxSprite>();
		
		for (i in 0...Settings.MAX_LIVES) {
			var s = new FlxSprite();
			s.loadGraphic(AssetPaths.life__png);
			s.x = barbg.x + 4 + (s.width + 4) * i;
			s.y = bar.y - s.height * 0.5;
			add(s);
			lifeSprites.push(s);
		}
	}
	
	var cf:FlxSprite;
	
	function godSay(f:FlxSprite) {
		if (cf != null) {
			remove(cf);
			cf = null;
		}
		FlxTween.tween(god, { y: FlxG.height - 80 }, 0.3, { complete: function(e:FlxTween) {
			
			Timer.delay(function() {
				talking = true;
				add(f);
				happyTalk.play();
				f.x = god.x - f.width - 4;
				f.y = god.y - f.height + 30;
				
				cf = f;
			}, 300);
			
			Timer.delay(function() {
				FlxTween.tween(god, { y: FlxG.height }, 0.1);
				talking = false;
				remove(f);
				cf = null;
			}, 1300);
			
		}});
	}
	

	function comboBroken() {
		if (Reg.combo > 7) {
			godSay(iLikeItCaption);	
		}else if(Reg.combo > 5) {
			godSay(coolCaption);
		}else if (Reg.combo > 3) {
			godSay(radCaption);
		}else if (Reg.combo > 2) {
			godSay(okCaption);
		}
	}
	
	override public function update():Void 
	{
		
		for (i in 0...Settings.MAX_LIVES) {
			lifeSprites[i].visible = Reg.lives > i;
		}
		
		if (talking) {
			if (cf != null) {
				cf.angle = Math.random() * 10;
			}
			god.angle = Math.random() * 20;
		}
		
		super.update();
		barbg.scale.x = Math.max(0, (Reg.health / Settings.MAX_HEALTH));
		
		scoreText.scale.x = scoreText.scale.y = 1;
		if (curScore < Reg.score) {
			if (curScore + 500 < Reg.score) {
				curScore += 500;
				scoreText.scale.x = scoreText.scale.y = 4;
			}else if (curScore + 100 < Reg.score) {
				curScore += 100;
				scoreText.scale.x = scoreText.scale.y = 3;
			}
			else if (curScore + 10 < Reg.score) {
				curScore += 10;
				scoreText.scale.x = scoreText.scale.y = 2;
			}else{
				curScore ++;
			}
		}else {
			curScore = Reg.score;
		}
		
		scoreText.x = (FlxG.width - scoreText.width) * 0.5;
		
		if (Reg.combo >= 2) {
			comboText.text = "COMBO: " + Reg.combo;
			comboText.x = FlxG.camera.target.x + (Math.random() * 4) - 2;
			comboText.y = FlxG.camera.target.y - 30 - FlxG.camera.scroll.y;
			var scale = Math.max(1, Reg.combo / 3);
			scale = Math.min(4, scale);
			comboText.scale.x = comboText.scale.y = scale;
		}else {
			comboText.text  = "";	
		}
		
		scoreText.text = "" + curScore;
		
	}
	
}