package entities;

import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;

/**
 * ...
 * @author jefvel
 */
class FallingGuy extends FlxSprite
{

	
	private var guyAcceleration = 1900;
	
	public function new(X:Float=0, Y:Float=0, ?SimpleGraphic:Dynamic) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.falling_sheet__png, true, 32, 32);
		
		animation.add("falling", [0, 1], 6, true);
		animation.add("dead", [2], 6, false);
		animation.play("falling");
		
	
		this.y = -100;
	}
	
	public override function update() {
		super.update();
		
		animation.play("falling");
	
		FlxG.camera.follow(this);
		FlxG.camera.deadzone.setSize(3000, 0);
		FlxG.camera.deadzone.x = -1000;
		
		var acc = 0;
		
		if(this.alive){
		
			if (FlxG.keys.pressed.A) {
				acc += -guyAcceleration;
			}
			if (FlxG.keys.pressed.D) {
				acc += guyAcceleration;
			}
		
		}
		
		this.acceleration.y = 100;
		
		this.acceleration.x = acc;
	
		this.maxVelocity.x = 200;
		this.maxVelocity.y = 1000;
		
		this.angularVelocity += this.velocity.x * 3 + Math.random();
		this.maxAngular = 300;
		this.drag.x = 200;
		
		if (this.x < 0) {
			this.x = 0;
			this.velocity.x = 300;
		}else if (this.x > FlxG.width - this.width) {
			this.x = FlxG.width - this.width;
			this.velocity.x = - 300;
		}
	}
	
	public function completelySplatter() {
		this.alive = false;
		this.angularVelocity = 0;
		this.angle = 0;
		this.animation.play("dead");
	}
}