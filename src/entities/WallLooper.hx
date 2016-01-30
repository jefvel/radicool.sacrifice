package entities;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

/**
 * ...
 * @author jefvel
 */
class WallLooper extends FlxSpriteGroup
{
	var walls:Array<Wall>;
	var vertWalls:Int;
	var totalHeight:Float;
	var wallHeight:Float;
	
	public var hitboxes:FlxSpriteGroup;

	public function new() 
	{
		super();
		var w:Wall = new Wall();
		wallHeight = w.height;
		vertWalls = Std.int(FlxG.height / wallHeight + 2);
		totalHeight = vertWalls * w.height;
		
		hitboxes = new FlxSpriteGroup();
		
		var left = new FlxSprite();
		left.loadGraphic(AssetPaths.wallhitbox__png);
		left.immovable = true;
		hitboxes.add(left);
		
		var right = new FlxSprite();
		right.loadGraphic(AssetPaths.wallhitbox__png);
		right.immovable = true;
		right.x = FlxG.width - right.width;
		hitboxes.add(right);
		
		walls = new Array<Wall>();
	
		
		for (i in 0...vertWalls) {
			var w = new Wall();
			walls.push(w);
			add(w);
			w.y = i * wallHeight;
			
			w = new Wall(true);
			add(w);
			walls.push(w);
			w.y =  i * wallHeight;
		}
	}
	
	public override function update() {
		hitboxes.y = Math.max(0, FlxG.camera.scroll.y);
		
		super.update();
		var dirty = false;
		for (wall in walls) {
			if (wall.y + wall.height < FlxG.camera.scroll.y) {
				if(wall.y + totalHeight < Settings.PIT_DEPTH){
					wall.y += totalHeight;
					wall.y = Math.floor(wall.y);
				}
			}
		}
	}
}