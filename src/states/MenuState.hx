package states;

import entities.PitBg;
import entities.PitTop;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxDestroyUtil;
import flixel.util.FlxMath;
import haxe.Timer;
import ui.TitleGraphic;

/**
 * A FlxState which can be used for the game's menu.
 */
class MenuState extends FlxState
{
	var playText:FlxText;
	var keys = ["W", "D"];
	var title:TitleGraphic;
	
	var splashSound:FlxSound;
	var splashSound2:FlxSound;
	
	var menuMusic:FlxSound;
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		splashSound = FlxG.sound.load(AssetPaths.pling__wav);
		splashSound2 = FlxG.sound.load(AssetPaths.pling2__wav);
		
		Timer.delay(function(){
			FlxG.sound.playMusic(AssetPaths.menumusic__wav, 1, true);
		}, 600);
		
		
		FlxG.sound.load(AssetPaths.intropling__wav).play();

		super.create();
		FlxG.camera.flash(0xeeeeee, 0.1);
		FlxG.mouse.visible = false;
		FlxG.worldBounds.set(0, 0, FlxG.width, Settings.PIT_DEPTH + 100);
		title = new TitleGraphic();
		var bg = new PitTop();
		bg.y = FlxG.height;
		add(bg);
		add(title);
	}
	
	var started = false;
	function startSacrifice() {
		if (started) {
			return;
		}
		started = true;
		splashSound.play();	
		FlxG.sound.music.fadeOut(0.2);
		title.coolFlash(function() {
			splashSound2.play();
			FlxG.camera.fade(0x630031, .63, false, function() {
				FlxG.switchState(new PlayState());
				FlxG.camera.fade(0x63003, .33, true);
			});
		});
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