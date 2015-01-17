package models 
{
	public class Grid
	// A grid is ~ a list of nodes (which contain their own positions)
	{
		private var rowNb:int;
		private var colNb:int;
		private var nodeList:Array = [];
		
		public function Grid(_rowNb:int, _colNb:int, _bombNb:int) 
		{
			this.rowNb = _rowNb;
			this.colNb = _colNb;
			var bombsPositions:Array = generateBombsPositions(_rowNb, _colNb, _bombNb);
			trace(bombsPositions.indexOf([0, 0]));
			for (var x:int = 0; x < _rowNb; x++ )
			{
				for (var y:int = 0; y < _colNb; y++ )
				{
					if (bombsPositions.indexOf([x, y]) >= 0)
					{
						trace ("BOMB");
					}
					var node:Node = new Node(x, y, (bombsPositions.indexOf([x, y]) >= 0), this);
					nodeList.push(node);	
				}
			}
			trace(nodeList);
		}
		
		private function generateBombsPositions(rowNb:int, colNb:int, bombNb:int):Array
		{
			var bombsToGenerate:int = bombNb;
			var bombsPositions:Array = [[0, 0]];
			var pickedX:int;
			var pickedY:int;
			while (bombsToGenerate != 0)
			{
				pickedX = Math.round(Math.random()*rowNb)
				pickedY = Math.round(Math.random() * colNb)
				if ( bombsPositions.indexOf([pickedX, pickedY]) < 0)
				{
					bombsPositions.push([pickedX, pickedY]);
					bombsToGenerate -= 1;
				}
			}
			return bombsPositions;
		}
		
		public function getRowNb():int
		{
			return this.rowNb;
		}
		
		public function getColNb():int
		{
			return this.colNb;
		}
		
		public function getNode(x:int, y:int):Node
		{
			var node:Node;
			for ( var nodeIndex:int = 0; nodeIndex < this.nodeList.length; nodeIndex ++ )
			{
				node = this.nodeList[nodeIndex];
				if ( x == node.getX() && y == node.getY())
				{
					return node;
				}
			}
			
			return null;
		}
	}

}