package options;

#if desktop
import Discord.DiscordClient;
#end
import Controls;
import flash.text.TextField;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxCamera;
import flixel.FlxSprite;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.addons.display.FlxGridOverlay;
import flixel.graphics.FlxGraphic;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.math.FlxMath;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;
// import flixel.util.FlxAxes;
import flixel.util.FlxColor;
import flixel.util.FlxSave;
import flixel.util.FlxTimer;
import haxe.Json;
import lime.utils.Assets;

using StringTools;

class OptionsState extends MusicBeatState
{
	var options:Array<String> = ['Controls', 'Visuals and UI', 'Gameplay', 'Save'];
	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var Trying:FlxButton;
	private var About:FlxText;

	private static var curSelected:Int = 0;
	public static var menuBG:FlxSprite;

	function openSelectedSubstate(label:String)
	{
		switch (label)
		{
			case 'Controls':
				openSubState(new options.ControlsSubState());
			case 'Visuals and UI':
				openSubState(new options.VisualsUISubState());
			case 'Gameplay':
				openSubState(new options.GameplaySettingsSubState());
			case 'Save':
				FlxG.sound.music.stop();
				FlxG.sound.play(Paths.sound('confirmMenu'));
				MusicBeatState.switchState(new TitleState());
				TitleState.initialized = false;
				TitleState.closedState = false;
				FlxG.sound.music.fadeOut(0.3);
				if (FreeplayState.vocals != null)
				{
					FreeplayState.vocals.fadeOut(0.3);
					FreeplayState.vocals = null;
				}
				FlxG.camera.fade(FlxColor.BLACK, 0.5, false, FlxG.resetGame, false);
				// FlxG.sound.playMusic(Paths.music('MusicCredits'), 1);
		}
	}

	var MusicOptions:FlxSound;
	var selectorLeft:Alphabet;
	var selectorRight:Alphabet;

	override function create()
	{
		#if desktop
		DiscordClient.changePresence("Options Menu", null);
		#end		

		Trying = new FlxButton(100, 0, "Trying with tutorial", ClickTrying);
		Trying.color = 0xFFea71fd;

		MusicOptions = new FlxSound().loadEmbedded(Paths.music('OptionsFresh'), true);
		MusicOptions.play();
		FlxG.sound.list.add(MusicOptions);

		var bg:FlxSprite = new FlxSprite();
		bg.loadGraphic(Paths.image('menuOptions'));
		bg.color = 0xFFea71fd;
		bg.updateHitbox();

		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		for (i in 0...options.length)
		{
			var optionText:Alphabet = new Alphabet(0, 0, options[i], true);
			// optionText.x = 100;
			optionText.screenCenter();
			optionText.color = 0x0051FF;
			optionText.y += (100 * (i - (options.length / 2))) + 50;
			// optionText.x += (100 * (i - (options.length / 2))) + 50;
			var scr:Float = (options.length - 4) * 0.135;
			if (options.length < 6)
				scr = 0;
			optionText.snapToPosition();
			grpOptions.add(optionText);
		}

		selectorLeft = new Alphabet(0, 0, '>', true);
		selectorLeft.color = 0x1900FF;
		add(selectorLeft);
		selectorRight = new Alphabet(0, 0, '<', true);
		selectorRight.color = 0x1900FF;
		add(selectorRight);

		changeSelection();
		ClientPrefs.saveSettings();

		About = new FlxText(0, 0, 0, 'Here You can change your controls X3', 32, true);
		About.color = 0x00FFFF;
		// About.screenCenter();
		// don't change that's pls okay
		// add(About);
		add(Trying);

		super.create();
	}

	private function ClickTrying()
	{
		FlxG.sound.play(Paths.sound('confirmMenu'));
		PlayState.SONG = Song.loadFromJson('tutorial', 'tutorial');
		PlayState.isStoryMode = false;
		LoadingState.loadAndSwitchState(new PlayState());
	}

	override function closeSubState()
	{
		super.closeSubState();
		ClientPrefs.saveSettings();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.UI_UP_P)
		{
			changeSelection(-1);
		}
		if (controls.UI_DOWN_P)
		{
			changeSelection(1);
		}

		if (controls.BACK)
		{
			MusicOptions.stop();
			FlxG.sound.play(Paths.sound('cancelMenu'));
			FlxG.sound.playMusic(Paths.music('freakyMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}

		if (controls.ACCEPT)
		{
			selectorRight.color = 0x00FFFF;
			selectorLeft.color = 0x00FFFF;
			openSelectedSubstate(options[curSelected]);
		}
	}

	function changeSelection(change:Int = 0)
	{
		curSelected += change;
		if (curSelected < 0)
			curSelected = options.length - 1;
		if (curSelected >= options.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpOptions.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			if (item.targetY == 0)
			{
				item.alpha = 1;
				selectorLeft.x = item.x - 63;
				selectorLeft.y = item.y;
				selectorRight.x = item.x + item.width + 15;
				selectorRight.y = item.y;
			}
		}
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}
}
