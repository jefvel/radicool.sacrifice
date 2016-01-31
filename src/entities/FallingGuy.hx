package entities;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxSound;
import flixel.tweens.FlxTween;
import flixel.util.FlxSignal;
import haxe.Timer;

/**
 * ...
 * @author jefvel
 */
class FallingGuy extends FlxSprite
{
	private var guyAcceleration = 2700;
	
	public var falling = false;
	public var killedSignal:FlxSignal;
	public var jumpedOff:FlxSignal;
	
	var explosionSound:FlxSound;
	
	public function new(X:Float=0, Y:Float=0, ?SimpleGraphic:Dynamic) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.falling_sheet__png, true, 32, 32);
		
		animation.add("falling", [0, 1], 6, true);
		animation.add("dead", [2], 6, false);
		animation.add("hurt", [3, 3, 3], 2, false);
		animation.add("standing", [4], 2, true);
		
		animation.play("standing");
		
		this.y = -200;
		this.x = 48;
		
		
		killedSignal = new FlxSignal();
		jumpedOff = new FlxSignal();
		
		explosionSound = FlxG.sound.load(AssetPaths.explosion__wav);
	}
	
	public function setActive() {
		FlxG.camera.follow(this);
		FlxG.camera.followLerp = 5.0;
		FlxG.camera.deadzone.setSize(3000, 0);
		FlxG.camera.deadzone.x = -1000;
	}
	
	public function jumpOff() {
		FlxG.timeScale = 0.4;
		FlxTween.tween(FlxG, { timeScale: 1.0 }, 1.0);
		falling = true;
		velocity.y = -140;
		angularVelocity = Math.random() * 30;
		animation.play("hurt");
		
		jumpedOff.dispatch();
	}
	
	public override function update() {
		super.update();
		
		if (!this.alive) {
			velocity.y *= 0.1;
			velocity.x *= 0.1;
			acceleration.x *= 0.1;
			acceleration.y *= 0.1;
			return;
		}
		
		if(velocity.y > 50){
			animation.play("falling");
		}
		
		
		var left = false;
		var right = false;
		
		for (touch in FlxG.touches.list) {
			if (touch.x < FlxG.width * 0.5) {
				left = true;
			}else {
				right = true;
			}
		}
		
		if (FlxG.keys.pressed.A) {
			left = true;
		}
		
		if (FlxG.keys.pressed.D) {
			right = true;
		}
		
		var acc = 0;
		if(falling){
			if(this.alive){
				if (left) {
					acc += -guyAcceleration;
				}
				if (right) {
					acc += guyAcceleration;
				}
			}
			
			this.acceleration.y = 1000;
			
			this.acceleration.x = acc;
		}
	
		this.maxVelocity.x = 200;
		this.maxVelocity.y = 1600;
		
		this.angularVelocity += (this.velocity.x * (3 + Math.random())) * 0.5;
		this.maxAngular = 900;
		this.drag.x = 200;
		
		if(falling){
			if (this.x < 0) {
				this.x = 0;
				this.velocity.x = 300;
			}else if (this.x > FlxG.width - this.width) {
				this.x = FlxG.width - this.width;
				this.velocity.x = - 300;
			}
		}
	}
	
	public function completelySplatter() {
		explosionSound.play();
		FlxG.timeScale = 0.2;
		this.alive = false;
		this.angularVelocity = 0;
		this.velocity.x *= 0.1;
		this.velocity.y = 0;
		falling = false;
		acceleration.y = 0;
		this.angle = 0;
		this.animation.play("dead");
		
		FlxG.camera.shake(0.01, 0.1);
		
		Timer.delay(function() {
			killedSignal.dispatch();
		}, 4000);
	}
}