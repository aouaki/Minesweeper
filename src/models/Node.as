package models 
{
    import flash.geom.Point;

    public class Node
    {
        // Same class for bombs and clue nodes
        public static const STATE_HIDDEN:String = "hidden";
        public static const STATE_FLAGGED:String = "marked";
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
        
        public function getState():String
        {
            return this._state;
        }
        
        
        public function setState(state:String):void
        {
            this._state = state;
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

            var neighborsCoordinates:Array = this.getNeighborsCoordinates();
            
            
            for ( var index:int = 0; index < neighborsCoordinates.length; index ++)
            {
                neighbor = this.getGrid().getNode(neighborsCoordinates[index].x, neighborsCoordinates[index].y)
                if (neighbor.isBomb())
                {
                    bombsCount += 1;
                }
            }
            
            return bombsCount;
        }
        
        public function getNeighborsCoordinates():Array
        {
            var neighborsCoordinates:Array = [];
            var x:int = this.getX();
            var y:int = this.getY();
            
            for (var i:int = Math.max(x - 1, 0); i < Math.min(x + 2, this.getGrid().getColNb()); i++)
            {
                for (var j:int = Math.max(y - 1, 0); j < Math.min(y + 2, this.getGrid().getRowNb()); j++ )
                {
                    if (!(i==x && j==y)) // doesn't count itself
                    {
                        neighborsCoordinates.push(new Point(i, j));
                    }       
                }
            }
            return neighborsCoordinates;
        }
    }

}
