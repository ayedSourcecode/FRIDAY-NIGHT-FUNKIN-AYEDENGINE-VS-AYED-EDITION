package;

import haxe.display.Protocol.FileParams;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.addons.display.FlxBackdrop;

class StartingEngine extends MusicBeatState
{
    var velocityBG:FlxBackdrop;
    var startingText:FlxText;
    var understand:FlxText;

    override function create() 
    {
        #if mobile
        FlxG.mouse.visible = true;
        #end

        PlatformUtil.sendWindowsNotification("Thanks For Download", "hey you thank you for download ayed engine \n
read ^w^", 3);

        FlxG.sound.playMusic(Paths.music('MusicCredits'), 1);

		velocityBG = new FlxBackdrop(Paths.image('velocityBG'));
		velocityBG.velocity.set(50, 50);
		add(velocityBG);

        startingText = new FlxText(0, 0, 0, '       Hey Thank You For Download Ayed Engine \n
        and the engine made by ayedfnfmaker and Stefan \n
        i hope you enjoy the engine and you can add more mods here -w- \n
        if you wanna support ayed engine click on space to joined server discord ayed engine community \n
        and click enter or mouse right to play \n
        and thats it i hope you understand', 20);
        startingText.color = FlxColor.WHITE;
        startingText.screenCenter();
        // startingText.alpha = 0.4;
        add(startingText);

        understand = new FlxText(0, 0, 0, 'i hope you understand ^w^ okay wait for loading . . .', 15);
        understand.color = FlxColor.CYAN;
        understand.screenCenter(X);

        super.create();
    }

    override function update(elapsed:Float)
    {
        if (FlxG.mouse.justPressed || FlxG.keys.justPressed.ENTER)
        {
            startingText.alpha = 0.5;
            add(understand);
            new FlxTimer().start(5, startingEngine, 1);
        }
        if (FlxG.keys.justPressed.SPACE)
        {
            CoolUtil.browserLoad('https://discord.gg/4gJFSV2U');
        }

        super.update(elapsed);
    }

    function startingEngine(timer:FlxTimer)
        {
            FlxG.sound.music.stop();
            FlxG.sound.play(Paths.sound('hey'));
            MusicBeatState.switchState(new TitleState());
            TitleState.initialized = false;
            TitleState.closedState = false;
            FlxG.camera.fade(FlxColor.BLACK, 0.5, false, FlxG.resetGame, false);
        }
}