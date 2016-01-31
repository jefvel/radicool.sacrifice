package entities;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;

/**
 * ...
 * @author jefvel
 */
class Bat extends Monster
{

	var batSpeed:Float = 200;
	public function new(X:Float=0, Y:Float=0, ?SimpleGraphic:Dynamic) 
	{
		batSpeed -= Math.random() * 20;
		this.name = "bat";
		this.damage = 2;
		this.score = 40;
		super(X, Y, SimpleGraphic);
		loadGraphic(AssetPaths.bat_sheet__png, true, 10, 8);
		animation.add("flap", [0, 1], 5, true);
		animation.play("flap");
		this.setFacingFlip(FlxObject.LEFT, true, false);
		this.facing = FlxObject.RIGHT;
		this.x = Math.random() * ( FlxG.width - 100) + 50;
	}
	
	public override function update() {
		super.update();
		this.maxVelocity.x = batSpeed;
		this.drag.x = 100;	
		
		if(this.facing == FlxObject.RIGHT) {
			this.acceleration.x = batSpeed * 10;
			
			if (this.x > FlxG.width - 50) {
				this.facing = FlxObject.LEFT;
			}
		} else {
			this.acceleration.x = -batSpeed * 10;	
			if (this.x < 50) {
				this.facing = FlxObject.RIGHT;
			}
		}
	}
	
}