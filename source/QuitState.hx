package;

#if desktop
import Discord.DiscordClient;
#end

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.addons.effects.chainable.FlxRainbowEffect;

class QuitState extends MusicBeatState
{
    private var bg:FlxSprite;
    var what:FlxText;
    var descBox:AttachedSprite;
    private var yes:FlxButton;
    private var not:FlxButton;
    var idk:FlxRainbowEffect;
    
    override function create()
    {
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Quit Mods ??????", null);
		#end

        #if mobile
        FlxG.mouse.visible = true;
        #end

        FlxG.sound.playMusic(Paths.music('MusicQuit'), 1, true);

        FlxG.mouse.visible = true;



        descBox = new AttachedSprite();
		descBox.makeGraphic(1, 1, 0xFF000000);
		descBox.screenCenter(Y);
		descBox.xAdd = -10;
		descBox.yAdd = -5;
		descBox.alphaMult = 0.6;
		descBox.alpha = 0.6;
		
        bg = new FlxSprite();
        bg.loadGraphic(Paths.image('menuBG' + FlxG.random.int(1, 5)));
        add(bg);
        bg.screenCenter();

        yes = new FlxButton(280, 220, "Yes", ClickExit);
        yes.color = FlxColor.RED;
        yes.screenCenter(Y);
        // yes.width(100, 230);
        // yes.height(100, 220);
        // yes.setSize(1000, 1000); 
        // yes.setSize(100, 100); 
        add(yes);


        what = new FlxText(0, 20, 0, 'are you sure???', 32);
        what.screenCenter(X);
        what.color = FlxColor.GREEN;
        add(what);
        add(descBox);

        not = new FlxButton(1000, 220, "not", ClickBack);
        not.color = FlxColor.BLUE;
        not.screenCenter(Y);
        // not.setSize(1000, 1000); 
        add(not);

        idk = new FlxRainbowEffect(1, 1, 2, 6);
        idk.active = true;

        super.create();
    }
	
    function ClickExit() 
    {
        Sys.exit(1);
    }

    private function ClickBack() 
    {
        idk.alpha = 0.5;
        FlxG.mouse.visible = false;
        FlxG.sound.play(Paths.sound('confirmMenu'));
        MusicBeatState.switchState(new MainMenuState());
        #if mobile
        FlxG.mouse.visible = true;
        #end
    }
}
