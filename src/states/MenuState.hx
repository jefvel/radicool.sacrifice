package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxDestroyUtil;
import flixel.util.FlxMath;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	var playText:FlxText;
	var keys = ["W", "A", "S", "D", "SPACE"];
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		super.create();
		FlxG.mouse.unload();
		playText = new FlxText(20, 20, 0, "Press anything to sacrifice");
		playText.color = 0x111111;
		add(playText);
	}
	
	function startSacrifice() {
		FlxG.switchState(new PlayState());
	}
	
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
		FlxDestroyUtil.destroy(playText);
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		super.update();
		if (FlxG.keys.anyJustPressed(keys)) {
			startSacrifice();
		}
	}	
}