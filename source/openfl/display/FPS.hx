package openfl.display;

import flixel.text.FlxText;
import flixel.util.FlxColor;
import haxe.Timer;
import openfl.events.Event;
import openfl.text.TextField;
import openfl.text.TextFormat;
import flixel.math.FlxMath;
#if gl_stats
import openfl.display._internal.stats.Context3DStats;
import openfl.display._internal.stats.DrawCallContext;
#end
#if flash
import openfl.Lib;
#end

#if openfl
import openfl.system.System;
#end

/**
	The FPS class provides an easy-to-use monitor to display
	the current frame rate of an OpenFL project
**/
#if !openfl_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end
class FPS extends TextField
{
	/**
		The current frame rate, expressed using frames-per-second
	**/
	public var currentFPS(default, null):Int;
	// public var ayedEngine:FlxText;

	@:noCompletion private var cacheCount:Int;
	@:noCompletion private var currentTime:Float;
	@:noCompletion private var times:Array<Float>;
	var currentColor:Int = 0;
	var skippedFrames = 0;
	var colorArray:Array<Int> = [
        0xFF9400D3,
        0xFF4B0082,
        0xFF0000FF,
        0xFF00FF00,
        0xFFFFFF00,
        0xFFFF7F00,
        0xFFFF0000

        ];

	public function new(x:Float = 10, y:Float = 10, color:Int = 0x000000)
	{
		// ayedEngine = new FlxText(10, 15, 0, 'ayedEngine' + MainMenuState.AyedEngineVersion, 5);
		
		super();

		this.x = x;
		this.y = y;

		
		currentFPS = 0;
		selectable = false;
		mouseEnabled = false;
		defaultTextFormat = new TextFormat("_sans", 12, color);
		autoSize = LEFT;
		multiline = true;
		text = "FPS: ";

		cacheCount = 0;
		currentTime = 0;
		times = [];

		#if flash
		addEventListener(Event.ENTER_FRAME, function(e)
		{
			var time = Lib.getTimer();
			__enterFrame(time - currentTime);
		});
		#end
	}

	// Event Handlers
	@:noCompletion
	private #if !flash override #end function __enterFrame(deltaTime:Float):Void
	{
		if (ClientPrefs.rainbowFPS)
			{
				if (skippedFrames >= 6)
				{
					if (currentColor >= colorArray.length)
						currentColor = 0;
					textColor = colorArray[currentColor];
					currentColor++;
					skippedFrames = 0;
				}
				else
				{
					skippedFrames++;
				}
			}
			else
			{
			textColor = 0xFF00E1FF;
			}
			
			currentTime += deltaTime;
			times.push(currentTime);

		while (times[0] < currentTime - 1000)
		{
			times.shift();
		}

		var currentCount = times.length;
		currentFPS = Math.round((currentCount + cacheCount) / 2);
		if (currentFPS > ClientPrefs.framerate) currentFPS = ClientPrefs.framerate;

		if (currentCount != cacheCount /*&& visible*/)
		{
			text = "FPS: " + currentFPS;
			var memoryMegas:Float = 0;
			var memoryPeaks:Float = 0;
			var peak:Float = 0;

			#if openfl
            memoryMegas = Math.abs(FlxMath.roundDecimal(System.totalMemory / 1000000, 1));
            if(memoryMegas > peak) peak = memoryMegas;
            text += "\nMEM: " + memoryMegas + " MB";
			text += "\nMEM PEAK: " + peak + " MB";
            #end

			// textColor = colorShit[0];
			if (memoryMegas > 3000 || currentFPS <= ClientPrefs.framerate / 2)
			{
				textColor = 0xFF770303;
			}

			#if (gl_stats && !disable_cffi && (!html5 || !canvas))
			text += "\ntotalDC: " + Context3DStats.totalDrawCalls();
			text += "\nstageDC: " + Context3DStats.contextDrawCalls(DrawCallContext.STAGE);
			text += "\nstage3DDC: " + Context3DStats.contextDrawCalls(DrawCallContext.STAGE3D);
			#end

			if(ClientPrefs.showAeVs)
			{
				text += "\nAYEDENGINE V:" + MainMenuState.AyedEngineVersion;
			}

		}
	// add(name);
		cacheCount = currentCount;
	}
}
