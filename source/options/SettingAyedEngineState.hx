package options;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;

using StringTools;

class SettingAyedEngineState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Setting Ayed Engine';
		rpcTitle = 'ayed engine setting ?!?!'; //for Discord Rich Presence

		var option:Option = new Option('Show image loading screen',
			"you know the image loading screen to show",
			'hideLoadingState',
			'bool',
			false);
		addOption(option);

        var option:Option = new Option('Rainbow FPS weee',
        "rainbow fps lollll",
        'rainbowFPS',
        'bool',
        true);
        addOption(option);

        var option:Option = new Option('Hide Time Num Or Text',
        "LOL you know the time bar num to hide it",
        'hideTimeNum',
        'bool',
        true);
        addOption(option);

        var option:Option = new Option('Low Quality ',
        "low the engine ???",
        'highGPU',
        'bool',
        false);
        addOption(option);
		
		var option:Option = new Option('Show Verions Ayed Engine down in FPS',
		"you show the version of ayed engine down in fps",
		'showAeVs',
		'bool',
		false);
		addOption(option);
		super();
	}

	var changedMusic:Bool = false;
	function onChangePauseMusic()
	{
		if(ClientPrefs.pauseMusic == 'None')
			FlxG.sound.music.volume = 0;
		else
			FlxG.sound.playMusic(Paths.music(Paths.formatToSongPath(ClientPrefs.pauseMusic)));

		changedMusic = true;
	}

	override function destroy()
	{
		if(changedMusic) FlxG.sound.playMusic(Paths.music('freakyMenu'));
		super.destroy();
	}
}
