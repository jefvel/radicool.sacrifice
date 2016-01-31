package entities;

import flixel.FlxG;
import flixel.FlxSprite;

/**
 * ...
 * @author jefvel
 */
class FaceMonster extends Monster
{

	var startX:Float;
	var radius:Float;
	var startY:Float;
	var rot = 0.0;
	
	public function new(X:Float=0, Y:Float=0, ?SimpleGraphic:Dynamic) 
	{
		super(X, Y, SimpleGraphic);
		this.name = "head";
		this.score = 100;
		
		this.damage = 4;
		
		rot = Math.random() * Math.PI * 2.0;
		
		loadGraphic(AssetPaths.face_sheet__png, true, 15, 15);
		
		animation.add("default", [0, 1], 16);
		animation.play("default");
		
		radius = Math.random() * 10 + 10;
		
		startX = Math.random() * (FlxG.width - (32 + radius) * 2) + (32 + radius);
		startY = Math.random() * (Settings.PIT_DEPTH - 300);
	}
	
	public override function update() {
		super.update();
		rot += 0.1;
		var newX = startX + Math.cos(rot) * radius;
		this.flipX = (newX < this.x);
		this.x = newX;
		this.y = startY + Math.sin(rot) * radius;
	}
}