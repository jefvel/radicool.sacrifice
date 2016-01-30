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

	
	private var guyAcceleration = 900;
	
	public function new(X:Float=0, Y:Float=0, ?SimpleGraphic:Dynamic) 
	{
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.falling_sheet__png, true, 32, 32);
		
		animation.add("falling", [0, 1], 6, true);
		animation.play("falling");
	}
	
	public override function update() {
		super.update();
		
		animation.play("falling");
	
		FlxG.camera.follow(this);
		FlxG.camera.deadzone.set( -100, -100, FlxG.width + 200, FlxG.height * 0.5);
		
		var acc = 0;
		
		if (FlxG.keys.pressed.A) {
			acc += -guyAcceleration;
		}
		if (FlxG.keys.pressed.D) {
			acc += guyAcceleration;
		}
		
		this.acceleration.x = acc;
		this.
		this.maxVelocity.x = 200;
		
		this.angularVelocity += this.velocity.x * 3;
		this.maxAngular = 200;
		this.drag.x = 200;
	}
}