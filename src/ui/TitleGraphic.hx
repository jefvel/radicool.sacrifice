package ui;

import entities.PitTop;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import haxe.Timer;
import motion.Actuate;

/**
 * ...
 * @author jefvel
 */
class TitleGraphic extends FlxSpriteGroup
{
	var title:FlxSprite;
	var bg:PitTop;
	var logotop:Float = 50;
	var time:Float = 0;
	var flashing = false;
	
	public function new(X:Float=0, Y:Float=0, MaxSize:Int=0) 
	{
		super(X, Y, MaxSize);
		this.y = -40;
		title = new FlxSprite();
		title.loadGraphic(AssetPaths.title__png, false);
		title.y = 50;
		
		title.x  = 0;
		title.x = (FlxG.width - title.width) * 0.5;
		title.scrollFactor.y = 0.5;
	
		bg = new PitTop();
		bg.y = 0;
		add(bg);
		add(title);
		
		for (i in 0...3) {
			Timer.delay(function() {
				FlxG.camera.flash(0xffffffff, 0.05);
			}, 100 * i);
		}
	}
	
	public override function update() {
		super.update();
		time += 0.1;
		if(!flashing){
			title.y = logotop + Math.sin(time * 0.3) * 6;
			this.y -= this.y * 0.05;
		}
	}
	
	public function coolFlash(callback:Dynamic) {
		flashing = true;
		FlxG.camera.flash(FlxColor.WHITE, 0.1, function() {
			Timer.delay(function(){
				FlxTween.tween(title, { y: 20, alpha:0 }, 0.3, { complete: function(f:FlxTween) {
					Timer.delay(function(){
						FlxG.camera.flash(FlxColor.WHITE, 0.1);
						if (callback != null) {
							callback();	
						}
					}, 400);
				}});
			}, 50);
		});
	}
	
}