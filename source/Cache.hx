#if sys
package;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionSprite.GraphicTransTileDiamond;
import flixel.addons.transition.FlxTransitionableState;
import flixel.addons.transition.TransitionData;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.math.FlxPoint;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.system.FlxSound;
import lime.app.Application;
#if windows
import Discord.DiscordClient;
#end
import openfl.display.BitmapData;
import openfl.utils.Assets;
import haxe.Exception;
import flixel.tweens.FlxEase;
import flixel.util.FlxColor;
import flixel.tweens.FlxTween;
#if cpp
import sys.FileSystem;
import sys.io.File;
#end

using StringTools;

class Cache extends MusicBeatState
{
	public static var bitmapData:Map<String,FlxGraphic>;
	public static var bitmapData2:Map<String,FlxGraphic>;

	var images = [];
	var music = [];

	var shitz:Alphabet ;
	var bgcolor:FlxSprite;

	override function create()
	{
		FlxG.mouse.visible = false;

		FlxG.worldBounds.set(0,0);

		bitmapData = new Map<String,FlxGraphic>();
		bitmapData2 = new Map<String,FlxGraphic>();

		bgcolor = new FlxSprite();
		// bgcolor.makeGraphic(0, 0, 0xFFB3FF00);
		bgcolor.color = 0xFFB3FF00;
		bgcolor.screenCenter();
		
		var menuBG:FlxSprite = new FlxSprite().loadGraphic(Paths.image('loadingGame/loadingGame' + FlxG.random.int(1, 14)));
		menuBG.screenCenter();
		add(bgcolor);
		add(menuBG);

		shitz = new Alphabet(12, 630, "Loading...", true);
		shitz.scrollFactor.set();
		shitz.color = 0xD9FF00;
		// shitz.setFormat("VCR OSD Mono", 50, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(shitz);

		#if cpp
		for (i in FileSystem.readDirectory(FileSystem.absolutePath("assets/shared/images/characters")))
		{
			if (!i.endsWith(".png"))
				continue;
			images.push(i);
		}

		for (i in FileSystem.readDirectory(FileSystem.absolutePath("assets/songs")))
		{
			music.push(i);
		}
		#end

		sys.thread.Thread.create(() -> {
			cache();
		});

		super.create();
	}

	override function update(elapsed) 
	{
		super.update(elapsed);
	}

	function cache()
	{
		#if !linux

		for (i in images)
		{
			var replaced = i.replace(".png","");
			var data:BitmapData = BitmapData.fromFile("assets/shared/images/characters/" + i);
			var graph = FlxGraphic.fromBitmapData(data);
			graph.persist = true;
			graph.destroyOnNoUse = false;
			bitmapData.set(replaced,graph);
			trace(i);
		}



		for (i in music)
		{
			trace(i);
		}


		#end
		FlxG.switchState(new TitleState());
	}

}
#end
