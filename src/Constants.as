package
{
    import flash.geom.Point;
    public class Constants 
    {
        public static const GameWidth:int  = 700;
        public static const GameHeight:int = 750;
        
        public static const CenterX:int = GameWidth / 2;
        public static const CenterY:int = GameHeight / 2;
        
        public static const EASY_INDEX:int = 0;
        public static const INTERMEDIATE_INDEX:int = 1;
        public static const HARD_INDEX:int = 2;
        
        public static const DIMENSIONS:Array = [[10, 10, 10], [20, 20, 50], [30, 30, 150]];
        
        public static const NODE_DIMENSION:int = 22;
        
        public static const LOOSE:String = "You lose !";
        public static const WIN:String = "You win !";
    }
}
