package;

#if desktop
import Discord.DiscordClient;
#end
// import editors.ChartingState;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.ui.FlxButton;

class EndingState extends MusicBeatState
{
    var bg:FlxSprite;
    var ending:FlxText;
    var restart:FlxButton;
    var leaving:FlxText;

    override function create()
    {
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("OMG HE IS FINISH MODS THANKS FOR PLAYING MODS X3", null);
		#end

        FlxG.sound.playMusic(Paths.music('MusicCredits'));

        FlxG.mouse.visible = true;

        bg = new FlxSprite();
        bg.loadGraphic(Paths.image('menuBG' + FlxG.random.int(1, 4)));
        bg.screenCenter();
        add(bg);

        var bgTwo:FlxSprite = new FlxSprite(0, 0);
        bgTwo.loadGraphic(Paths.image('EndingBG/ImageEnding1'));
        bgTwo.screenCenter();
        add(bgTwo);

        FlxTween.tween(bgTwo, {y: bgTwo.y + 50}, 0.6, {ease: FlxEase.quadInOut, type: PINGPONG});

        ending = new FlxText(0, 0, 0, "
        Thank you for playing my mods \n
        soo i see you on next update V2.0 or V3.0 \n
        press enter to go credits and Press ESC to go back to freeplay \n
        And The Secret Is Go In MainMenu And Click F7 And boom lol \n
                            see you later X3         ", 28);
        ending.screenCenter();
        ending.color = FlxColor.PINK;
        add(ending);

        leaving = new FlxText(0, 0, 0, 'uuuuuhhhhh something wrong -w-', 32);
        leaving.screenCenter();
        leaving.color = FlxColor.RED;

        // restart = new FlxButton(90, 540, 'playagain', ClickPlayAgain);
        // restart.color = FlxColor.BLUE;
        // add(restart); // i think i wanna delete it

        super.create();
    }

    override function update(elapsed:Float)
        { 
            if (FlxG.mouse.justPressed)
            {
                add(leaving);
            }
            if (controls.BACK)
            {
                // selectedSomethin = true;
                FlxG.sound.play(Paths.sound('cancelMenu'));
                MusicBeatState.switchState(new FreeplayState());
            }
            
            if (controls.ACCEPT)
            {
                FlxG.sound.play(Paths.sound('confirmMenu'));
                MusicBeatState.switchState(new CreditsState());
            }
        }

}