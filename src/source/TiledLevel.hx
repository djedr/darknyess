package;

import openfl.Assets;
import flash.geom.Point;
import haxe.io.Path;
import haxe.xml.Parser;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.tile.FlxTilemap;
import flixel.addons.editors.tiled.TiledMap;
import flixel.addons.editors.tiled.TiledObject;
import flixel.addons.editors.tiled.TiledObjectGroup;
import flixel.addons.editors.tiled.TiledTileSet;

class TiledLevel extends TiledMap{

	private inline static var TILESETS_PATH = "assets/images/";
	
	public var 	foregroundTiles 		: FlxGroup;
	public var 	backgroundTiles 		: FlxGroup;

	public var 	pointStart 				: Point;

	private var collidableObjects 		: Array<FlxObject>;
	private var collidableTileLayers 	: Array<FlxTilemap>;
	
	public function new(tiledLevel:Dynamic){

		super(tiledLevel);
		
		foregroundTiles = new FlxGroup();
		backgroundTiles = new FlxGroup();

		collidableObjects 	= new Array();
		
		FlxG.camera.setBounds(0, 0, fullWidth, fullHeight, true);
		
		for (tileLayer in layers){
			var tileSheetName:String = tileLayer.properties.get("tileset");
			
			if (tileSheetName == null){
				throw "'tileset' property not defined for the '" + tileLayer.name + "' layer. Please add the property to the layer.";
			}

			var tileSet:TiledTileSet = null;
			for (ts in tilesets){
				if (ts.name == tileSheetName){
					tileSet = ts;
					break;
				}
			}
			if (tileSet == null){
				throw "Tileset '" + tileSheetName + " not found. Did you mispell the 'tilesheet' property in " + tileLayer.name + "' layer?";
			}
				
			var imagePath 		= new Path(tileSet.imageSource);
			var processedPath 	= TILESETS_PATH + imagePath.file + "." + imagePath.ext;
			
			var tilemap:FlxTilemap = new FlxTilemap();
			tilemap.widthInTiles = width; 
			tilemap.heightInTiles = height;
			tilemap.loadMap(tileLayer.tileArray, processedPath, tileSet.tileWidth, tileSet.tileHeight, 0, 1, 1, 1);

			if (tileLayer.properties.contains("nocollide")){
				backgroundTiles.add(tilemap);
			}
			else{
				if (collidableTileLayers == null){
					collidableTileLayers = new Array<FlxTilemap>();
				}
				
				foregroundTiles.add(tilemap);
				collidableTileLayers.push(tilemap);
			}
		}
	}
	
	public function loadObjects(state:PlayState){
		for (group in objectGroups){
			for (o in group.objects){
				loadObject(o, group, state);
			}
		}
	}
	
	private function loadObject(o:TiledObject, g:TiledObjectGroup, state:PlayState){
		var x:Int = o.x;
		var y:Int = o.y;
		
		// objects in tiled are aligned bottom-left (top-left in flixel)
		if (o.gid != -1){
			y -= g.map.getGidOwner(o.gid).tileHeight;
		}

		if(g.name.toLowerCase() == "kolizje")
		{
			var newObject = new FlxObject(x, y, o.width, o.height);
			newObject.immovable = true;
			collidableObjects.push(newObject);

			return;
		}

		// if(g.name.toLowerCase() == "deathly"){
		// 	state.hazards.add(new FlxObject(x, y, o.width, o.height));
		// }
		// trace(o.type.toLowerCase());
		
		switch (o.type.toLowerCase()){

			case "start":
				// trace("przebog");

				pointStart = new Point(x, y);

			// case "deathly":
				
			// case "floor":
			// 	var floor = new FlxObject(x, y, o.width, o.height);
			// 	state.floor = floor;
				
			// case "coin":
			// 	var tileset = g.map.getGidOwner(o.gid);
			// 	var coin = new FlxSprite(x, y, TILESETS_PATH + tileset.imageSource);
			// 	state.coins.add(coin);
				
			// case "exit":
			// 	// Create the level exit
			// 	var exit = new FlxSprite(x, y);
			// 	exit.makeGraphic(32, 32, 0xff3f3f3f);
			// 	exit.exists = false;
			// 	state.exit = exit;
			// 	state.add(exit);
		}
	}
	
	public function collideWithLevel(obj:FlxObject, ?notifyCallback:FlxObject->FlxObject->Void, ?processCallback:FlxObject->FlxObject->Bool):Bool{
		var collision : Bool = false;

		if (collidableTileLayers != null){
			for (map in collidableTileLayers){
				// IMPORTANT: Always collide the map with objects, not the other way around. 
				//			  This prevents odd collision errors (collision separation code off by 1 px).
				if(FlxG.overlap(map, obj, notifyCallback, processCallback != null ? processCallback : FlxObject.separate)){
					return true;
				}
			}
		}

		// if(!collision){
			for(i in 0...collidableObjects.length){
				if(FlxG.overlap(collidableObjects[i], obj, notifyCallback, processCallback != null ? processCallback : FlxObject.separate)){
					return true;
				}
			}
		// } 

		return collision;
	}
}