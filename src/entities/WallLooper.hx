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
	var extraWalls = 2;
	
	public var hitboxes:FlxSpriteGroup;

	public function new() 
	{
		super();
		var w:Wall = new Wall();
		wallHeight = w.height;
		vertWalls = Std.int(FlxG.height / wallHeight + 2);
		totalHeight = (vertWalls + extraWalls) * w.height;
		
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
		
		add(hitboxes);
		
		walls = new Array<Wall>();
		
		for (i in 0...(vertWalls)) {
			var w = new Wall();
			walls.push(w);
			add(w);
			w.y = (i) * wallHeight;
			
			w = new Wall(true);
			add(w);
			walls.push(w);
			w.y =  (i) * wallHeight;
		}
		
		var w = new FlxSprite();
		w.loadGraphic(AssetPaths.first_wall__png);
		add(w);
		
		w = new FlxSprite();
		w.loadGraphic(AssetPaths.first_wall__png);
		w.flipX = true;
		w.x = FlxG.width - w.width;
		add(w);
		
	}
	
	public override function draw() {
		
		hitboxes.y = Math.max(-50, FlxG.camera.scroll.y);
		
		var startY = Math.max(1, Std.int(FlxG.camera.scroll.y / wallHeight) - 1) * wallHeight;
		
		for (i in 0...vertWalls) {
			walls[i * 2].y = walls[i * 2 + 1].y = startY + wallHeight * i;
		}
		
		super.draw();
	}
}