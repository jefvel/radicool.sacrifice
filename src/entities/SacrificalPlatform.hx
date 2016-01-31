package entities;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import haxe.Timer;

/**
 * ...
 * @author jefvel
 */
class SacrificalPlatform extends FlxSpriteGroup
{

	var platform:FlxSprite;
	var guy:FallingGuy;
	var platformPos = 0.0;
	var sacrificer:FlxSprite;
	
	public function new() 
	{
		super();
		
		platform = new FlxSprite();
		platform.loadGraphic(AssetPaths.platform__png);
		
		sacrificer = new FlxSprite();
		sacrificer.loadGraphic(AssetPaths.knuff_sheet__png, true, 16, 16);
		sacrificer.animation.add("push", [1, 2, 3, 0], 16, false);
		add(sacrificer);
		sacrificer.x = platform.width - sacrificer.width - 25;
		sacrificer.y = -16;
		
		add(platform);
		
		closePlatform();
		
		x = -width;
	}
		
	public function extendPlatform() {
		platformPos = 0;
	}
	
	public function closePlatform() {
		platformPos = -width;
	}
	
	public function attachToPlatform(a:FallingGuy) {
		guy = a;
		Timer.delay(function(){
			extendPlatform();
			a.jumpedOff.addOnce(guyJumpedOff);
		}, 400);
	}
	
	function guyJumpedOff() {
		guy = null;
		sacrificer.animation.play("push");
		Timer.delay(closePlatform, 300);
	}
	
	public override function update() {
		super.update();
		x -= (x - platformPos) * 0.1;
		
		if (guy != null) {
			if(!guy.falling) {
				guy.x = x + width - guy.width;
				guy.angle = 0;
				guy.angularVelocity = 0;
			}
		}
	}
}