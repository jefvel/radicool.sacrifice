package ui;

import flixel.group.FlxSpriteGroup;
import states.PlayState;
import flixel.text.FlxText;
import haxe.Json;
import util.FontInfo;
import openfl.display.Bitmap;
import openfl.text.TextFieldAutoSize;
import openfl.utils.Timer;
import openfl.Assets;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.Lib;
import openfl.Vector;
import openfl.text.TextField;
import openfl.text.TextFormatAlign;

class UI extends FlxSpriteGroup
{
	private var scoreText:FlxText;
	private var countdownText:FlxText;
	private var debugMessage:FlxText;

	public function new() {
		super();
		scoreText = createScoreText();

		countdownText = createCountdownText();
		debugMessage = createDebugMessageText();
		debugMessage.color = 0xffff00;
		debugMessage.visible = true;
		
		add(debugMessage);
		add(scoreText);
		add(countdownText);
	}

	public function updateCountdown(msRemaining) {
		countdownText.text = "" + Math.fceil((msRemaining) / 1000);
	}

	public function updateUIValues(gameValues:GameValues) {
		scoreText.text = ": " + gameValues.scoreCount;
	}

	public function showDebugMessage(message:String) {
		debugMessage.text = message;
		debugMessage.visible = true;
	}

	public function hideDebugMessage() {
		debugMessage.visible = false;	
	}

	public static function createDebugMessageText():FlxText{
		var textField = new FlxText(15, 100, 0, "RADICOOL");
		//textField.font = FontInfo.getCustomTextFormat(24, TextFormatAlign.CENTER);
		textField.width = Lib.current.stage.stageWidth;
		textField.x = 0;//Lib.current.stage.stageWidth/2;
		textField.y = Lib.current.stage.stageHeight / 2;
		return textField;
	}

	private static function createCountdownText():FlxText{
		var textField = new FlxText();
		//textField.font = FontInfo.getCustomTextFormat(24, TextFormatAlign.CENTER);
		textField.width = Lib.current.stage.stageWidth;
		textField.x = 0;
		textField.y = 35;
		return textField;
	}

	private static function createScoreText():FlxText{
		var textField = new FlxText();
		//textField.font = FontInfo.getTextFormat();
		textField.width = 200;
		textField.x = Lib.current.stage.stageWidth-250;
		textField.y = 12;
		return textField;
	}
}