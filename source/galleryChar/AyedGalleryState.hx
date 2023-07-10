package galleryChar;

#if desktop
import Discord.DiscordClient;
#end

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;
import flixel.FlxCamera;
import haxe.Json;
import Controls;

using StringTools;

class AyedGalleryState extends MusicBeatState
{
    public static var ayedGallery:Array<String> = ['ayedshoot', 'ayedfunny', 'ayedcute', 'ayedenianew', 'ayedending'];
    private var curSelected:Int = 0;
    var ayedPics:FlxTypedGroup<FlxSprite>;

    var camGame:FlxCamera;
    var bg:FlxSprite;
    var textGallery:FlxText;

    override function create() 
    {

        camGame = new FlxCamera();
        add(camGame);
        
        #if desktop
        DiscordClient.changePresence('AyedGallery', null);
        #end

        FlxG.mouse.visible = true;

        bg = new FlxSprite(0, 0);
        bg.loadGraphic(Paths.image('menuBG'));
        bg.screenCenter();// LOOOOOOOOOOOOOOOOOOOOOOOOOOL
        add(bg);

        textGallery = new FlxText(0, 0, 10, 'AyedGallery', 20);
        textGallery.color = FlxColor.GREEN;
        add(textGallery);

        ayedPics = new FlxTypedGroup<FlxSprite>();
        add(ayedPics);

        for (i in 0...ayedGallery.length)
        {
            var ayedPic:FlxSprite = new FlxSprite(0, 0);
            // ayedPic.isMenuItem = true;
            // ayedPic.scale.x = scale;
			// ayedPic.scale.y = scale;
            ayedPic.loadGraphic(Paths.image('Gallery/ayed/' + ayedGallery[i]));
			ayedPic.ID = i;
            ayedPic.screenCenter();
			// ayedPic.x = 100;
			ayedPics.add(ayedPic);
			var scr:Float = (ayedGallery.length - 4) * 0.135;
			if (ayedGallery.length < 6)
				scr = 0;
			// menuItem.scrollFactor.set(0, scr);
			ayedPic.antialiasing = ClientPrefs.globalAntialiasing;
			// menuItem.setGraphicSize(Std.int(menuItem.width * 0.58));
			ayedPic.updateHitbox();
        }

        changeImage();

        super.create();
    }

    override function update(elasped:Float)
    {
        if (controls.UI_LEFT_P)
        {
            changeImage(-1);
        }
        if (controls.UI_RIGHT_P)
        {
            changeImage(1);
        }
        if (controls.BACK)
        {
            FlxG.sound.play(Paths.sound('cancelMenu'));
            MusicBeatState.switchState(new GalleryState());
        }
        super.update(elasped);
    }

    function changeImage(change:Int = 0)
    {
        if (change != 0) FlxG.sound.play(Paths.sound("scrollMenu"), 0.4);
        curSelected += change;

		if (curSelected >= ayedGallery.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = ayedGallery.length - 1;
    }
}