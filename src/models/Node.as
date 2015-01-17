package models 
{
    import flash.geom.Point;

    public class Node
    // Same class for bombs and clue nodes
    {
        public static const STATE_HIDDEN:String = "hidden";
        public static const STATE_MARKED:String = "marked";
        public static const STATE_REVEALED:String = "revealed";
        
        private var _x:int;
        private var _y:int;
        private var _isBomb:Boolean;
        private var _state:String;
        private var _grid:Grid;
        
        public function Node(x:int, y:int, isBomb:Boolean, grid:Grid)
        {
            this._x = x;
            this._y = y;
            this._isBomb = isBomb;
            this._state = STATE_HIDDEN;
            this._grid = grid;
        }
        
        public function getX():int
        {
            return this._x;
        }
        
        public function getY():int
        {
            return this._y;
        }
        
        public function getGrid():Grid
        {
            return this._grid;
        }
        
        public function isBomb():Boolean
        {
            return this._isBomb;
        }
        
        public function setBomb(bool:Boolean):void
        {
            this._isBomb = bool;
        }
        public function getNeighborBombsCount():int
        {
            // Returns the amount of bombs on the four neighbor
            var bombsCount:int = 0;
            var neighbor:Node;
            var neighborsCoordinates:Array = [];
            var x:int = this.getX();
            var y:int = this.getY();
            
            for (var i:int = -1; i < 2; i++)
            {
                for (var j:int = -1; j < 2; j++)
                {
                    if (!(i==0 && j==0)) // doesn't count itself
                    {
                        neighborsCoordinates.push(new Point(x + i, y + j));
                    }
                }
            }
            for ( var index:int = 0; index < neighborsCoordinates.length; index ++)
            {
                neighbor = this.getGrid().getNode(neighborsCoordinates[index].x, neighborsCoordinates[index].y)
                if (neighbor != null)
                {                    
                    if (neighbor.isBomb())
                    {
                        bombsCount += 1;
                    }
                }
            }
            
            return bombsCount;
        }
    }

}