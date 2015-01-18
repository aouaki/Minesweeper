package
{
    import flash.display.Bitmap;
    import flash.utils.Dictionary;
    
    import starling.textures.Texture;

    public class Assets 
    {
        [Embed(source="../assets/images/home-bg.png")]
        public static const HomeBg:Class;
        [Embed(source="../assets/images/bomb-icon.png")]
        public static const BombIcon:Class;
        [Embed(source="../assets/images/flag-icon.png")]
        public static const FlagIcon:Class;
        
        public static var gameTextures:Dictionary = new Dictionary();
        
        public static function getTexture(name:String):Texture
        // Returns requested texture and stores it in gameTextures if it's not already
        {
            if (gameTextures[name] == undefined)
            {
                var bitmap:Bitmap = new Assets[name]();
                gameTextures[name] = Texture.fromBitmap(bitmap);
            }
            
            return gameTextures[name];
        }
    }
}
