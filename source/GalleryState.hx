package;

// import Alphabet;
#if desktop
import Discord;
#end
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.addons.transition.FlxTransitionableState;
import flixel.math.FlxMath;
import flixel.util.FlxColor;
import Controls;

using StringTools;

class GalleryState extends MusicBeatState
{
    var itemsShits:Array<String> = ['SOZY SISTER', 'AYED', 'NITERHALEREAL', 'MOTHER', 'EZRA'];
    private static var curSelected:Int = 0;
    private var grpItemTexts:FlxTypedGroup<Alphabet>;

    var bg:FlxSprite;
    var gallerywel:FlxText;

    override function create()
    {
        FlxG.camera.bgColor = FlxColor.BLACK;

        #if desktop
        DiscordClient.changePresence('Gallery Time', 'gallery in ayed engine', 'GalleryState');
        #end

        bg = new FlxSprite(0, 0);
        // bg.screenCenter();
        bg.loadGraphic(Paths.image('menuBG'));
        bg.alpha = 0.5;
        add(bg);

        var bgTwo:FlxSprite = new FlxSprite(0, 0).makeGraphic(0, 0, FlxColor.BLACK);
        bgTwo.alpha = 0.5;
        add(bgTwo);

        gallerywel = new FlxText(0, 0, 0, 'VERSIONS GALLERY: ' + MainMenuState.AyedEngineVersion, 30);
        gallerywel.setFormat("VCR OSD Mono", 30, FlxColor.CYAN, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.GREEN);
        add(gallerywel);
        

        grpItemTexts = new FlxTypedGroup<Alphabet>();
		add(grpItemTexts);

        for (i in 0...itemsShits.length)
        {
            var itemText:Alphabet = new Alphabet(90, 320, itemsShits[i], true);
            itemText.isMenuItem = true;
            itemText.screenCenter(X);
            itemText.targetY = i;
            itemText.ID = i;
            grpItemTexts.add(itemText);
            itemText.snapToPosition();
        }

        changeSelection();

        super.create();
    }
    
    override function update(elapsed:Float)
    {
        if (controls.UI_UP_P)
        {
            changeSelection(-1);
        }
        if (controls.UI_DOWN_P)
        {
            changeSelection(1);
        }
        if (controls.ACCEPT)
            {
                switch(itemsShits[curSelected]) {
                    case 'SOZY SISTER':
                        MusicBeatState.switchState(new EndingState());
                    case 'AYED':
                        MusicBeatState.switchState(new galleryChar.AyedGalleryState());
                    case 'NITERHALEREAL':
                        MusicBeatState.switchState(new QuitState());
                    case 'MOTHER':
                        MusicBeatState.switchState(new CreditsState());
                    case 'EZRA':
                        MusicBeatState.switchState(new MainMenuState());
                }
            }
        if (controls.BACK)
        {
            FlxG.sound.play(Paths.sound('cancelMenu'));
            MusicBeatState.switchState(new MainMenuState());
        }
        super.update(elapsed);
    }
    
	function changeSelection(change:Int = 0)
    {
        if (change != 0) FlxG.sound.play(Paths.sound("scrollMenu"), 0.4);
        curSelected += change;

        if (curSelected < 0)
            curSelected = itemsShits.length - 1;
        if (curSelected >= itemsShits.length)
            curSelected = 0;

        var bullShit:Int = 0;
        
            for (item in grpItemTexts.members)
            {
                var onScreen = ((item.y > 0 && item.y < FlxG.height) || (bullShit - curSelected < 10 &&  bullShit - curSelected > -10));
                if (onScreen){ // If item is onscreen, then actually move and such
                    if (!item.alive){
                        item.revive();
                        if (change < 0 ) item.y = -500; else item.y = FlxG.height + 300;
                    }
                    item.targetY = bullShit - curSelected;
                        item.alpha = 0.6;
                        if (item.targetY == 0)
                        {
                            item.alpha = 1;
                        }
                }else{item.kill();} // Else, try to kill it to lower the amount of sprites loaded
                bullShit++;
            }
    }
}

