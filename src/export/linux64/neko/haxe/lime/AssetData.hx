package lime;


import lime.utils.Assets;


class AssetData {

	private static var initialized:Bool = false;
	
	public static var library = new #if haxe3 Map <String, #else Hash <#end LibraryType> ();
	public static var path = new #if haxe3 Map <String, #else Hash <#end String> ();
	public static var type = new #if haxe3 Map <String, #else Hash <#end AssetType> ();	
	
	public static function initialize():Void {
		
		if (!initialized) {
			
			path.set ("assets/images/background_night.png", "assets/images/background_night.png");
			type.set ("assets/images/background_night.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/platforms.png", "assets/images/platforms.png");
			type.set ("assets/images/platforms.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/ludzik.png", "assets/images/ludzik.png");
			type.set ("assets/images/ludzik.png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/images/ludzik (kopia).png", "assets/images/ludzik (kopia).png");
			type.set ("assets/images/ludzik (kopia).png", Reflect.field (AssetType, "image".toUpperCase ()));
			path.set ("assets/data/level1.tmx", "assets/data/level1.tmx");
			type.set ("assets/data/level1.tmx", Reflect.field (AssetType, "text".toUpperCase ()));
			path.set ("assets/sounds/beep.ogg", "assets/sounds/beep.ogg");
			type.set ("assets/sounds/beep.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/sounds/flixel.ogg", "assets/sounds/flixel.ogg");
			type.set ("assets/sounds/flixel.ogg", Reflect.field (AssetType, "sound".toUpperCase ()));
			path.set ("assets/fonts/nokiafc22.ttf", "assets/fonts/nokiafc22.ttf");
			type.set ("assets/fonts/nokiafc22.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			path.set ("assets/fonts/arial.ttf", "assets/fonts/arial.ttf");
			type.set ("assets/fonts/arial.ttf", Reflect.field (AssetType, "font".toUpperCase ()));
			
			
			initialized = true;
			
		} //!initialized
		
	} //initialize
	
	
} //AssetData
