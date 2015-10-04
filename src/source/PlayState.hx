package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.util.FlxPoint;

/**
 *
 * 			darknyeß
 *
 */

class PlayState extends FlxState{


	public 	var 	level 			: TiledLevel;
	public 	var 	player 			: Player;

	private var 	background 		: FlxSprite;	


	override public function create():Void{
		super.create();

		FlxG.mouse.useSystemCursor  = true;
		FlxG.fixedTimestep 			= false;

		createBackground();

		level = new TiledLevel("assets/data/level1.tmx");

		level.loadObjects(this);

		add(level.backgroundTiles);

		if(level.pointStart != null){
			player = new Player(Std.int(level.pointStart.x), Std.int(level.pointStart.y));
			add(player);
			FlxG.camera.follow(player, 1);
		}

		add(level.foregroundTiles);

	}
	

	override public function destroy():Void{

		// let's make garbage man's life a tad easier.

		player 	= null;
		level 	= null;

		super.destroy();
	}


	override public function update():Void{

		if(player != null){
			player.updateInput();
		}

		// yes, this is exactly where this thingie should be.
		super.update();

		if(player != null){
			player.onUpdate();
		}

		if(level != null){
			level.collideWithLevel(player, onCollision);
		}

	}


	private function createBackground(){
		background = new FlxSprite(0, 0, "assets/images/background_night.png");
		background.scrollFactor.set(0, 0);
		add(background);
	}


	private function onCollision(obj1 : flixel.FlxObject, obj2 : flixel.FlxObject){
		//
	}

}