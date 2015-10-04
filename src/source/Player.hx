package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxObject;
import flixel.util.FlxMath;
import flash.geom.Point;

class Player extends FlxSprite{


	public function new(x : Int, y : Int){
		super(x, y);

		loadGraphic("assets/images/ludzik.png", true, 32, 32);
		animation.add("idle", [0, 2, 1, 2], 4, true);
		animation.add("walk", [10, 11, 12, 13, 14, 15, 16, 17], 10, true);
		animation.play("idle", true);

		maxVelocity.set(80, 200);
		acceleration.y = 200;
		drag.x = maxVelocity.x * 4;
	}


	public function onUpdate(){
		// kindly do stuff.

	}


	public function updateInput(){
		acceleration.x = 0;
		var running : Bool = false;
		
		if (FlxG.keys.anyPressed(["LEFT", "A"])){
			acceleration.x = -maxVelocity.x * 4;
			this.flipX = true;
			running = true;
		}
		
		if (FlxG.keys.anyPressed(["RIGHT", "D"])){
			acceleration.x = maxVelocity.x * 4;
			this.flipX = false;
			running = true;
		}
		
		if (FlxG.keys.anyJustPressed(["SPACE", "UP", "W"]) && isTouching(FlxObject.FLOOR)){
			velocity.y = -maxVelocity.y * 0.7;
		}

		if(running){
			animation.play("walk", false);

		} else {
			animation.play("idle", false);
		}
	}


}