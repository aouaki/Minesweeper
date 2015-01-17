package models 
{
    import flash.geom.Point;
    public class Grid
    // A grid is ~ a list of nodes (which contain their own positions)
    {
        private var _rowNb:int;
        private var _colNb:int;
        private var _nodeList:Array = [];
        
        public function Grid(rowNb:int, colNb:int, bombNb:int) 
        {
            this._rowNb = rowNb;
            this._colNb = colNb;
            for (var x:int = 0; x < rowNb; x++ )
            {
                for (var y:int = 0; y < colNb; y++ )
                {
                    var node:Node = new Node(x, y, false, this);
                    this._nodeList.push(node);    
                }
            }
            
            var bombsPositions:Array = generateBombsPositions(rowNb, colNb, bombNb);
            
            var bombPoint:Point;
            for (var index:int = 0; index < bombsPositions.length; index++)
            {
                bombPoint = bombsPositions[index];
                this.getNode(bombPoint.x, bombPoint.y).setBomb(true);
            }
            trace(this._nodeList);
        }
        
        private function generateBombsPositions(rowNb:int, colNb:int, bombNb:int):Array
        {
            var bombsToGenerate:int = bombNb;
            var bombsPositions:Array = [];
            var pickedX:int;
            var pickedY:int;
            while (bombsToGenerate != 0)
            {
                pickedX = Math.round(Math.random() * (rowNb-1))
                pickedY = Math.round(Math.random() * (colNb-1))
                if ( bombsPositions.indexOf([pickedX, pickedY]) < 0)
                {
                    bombsPositions.push(new Point(pickedX, pickedY));
                    bombsToGenerate -= 1;
                }
            }
            return bombsPositions;
        }
        
        public function getRowNb():int
        {
            return this._rowNb;
        }
        
        public function getColNb():int
        {
            return this._colNb;
        }
        
        public function getNode(x:int, y:int):Node
        {
            var node:Node;
            for ( var nodeIndex:int = 0; nodeIndex < this._nodeList.length; nodeIndex ++ )
            {
                node = this._nodeList[nodeIndex];
                if ( x == node.getX() && y == node.getY())
                {
                    return node;
                }
            }
            
            return null;
        }
    }

}