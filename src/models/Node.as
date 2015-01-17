package models 
{

	public class Node
	// Same class for bombs and clue nodes
	{
		public static const STATE_HIDDEN:String = "hidden";
		public static const STATE_MARKED:String = "marked";
		public static const STATE_REVEALED:String = "revealed";
		
		private var x:int;
		private var y:int;
		private var isBomb:Boolean;
		private var state:String;
		private var grid:Grid;
		
		public function Node(_x:int, _y:int, _isBomb:Boolean, _grid:Grid)
		{
			this.x = _x;
			this.y = _y;
			this.isBomb = _isBomb;
			this.state = STATE_HIDDEN;
			this.grid = _grid;
		}
		
		public function getX():int
		{
			return this.x;
		}
		
		public function getY():int
		{
			return this.y;
		}
		
		public function getNeighborBombsCount():int
		{
			var bombsCount:int = 0;
			var neighbor:Node;
			var neighborsCoordinates:Array = [ [this.x + 1, this.y], [this.x - 1, this.y], [this.x, this.y + 1], [this.x, this.y - 1] ];
			for ( var index:int = 0; index < neighborsCoordinates.length; index ++)
			{
				neighbor = this.grid.getNode(neighborsCoordinates[index][0], neighborsCoordinates[index][1])
				if (neighbor != null)
				{					
					if (neighbor.isBomb)
					{
						bombsCount += 1;
					}
				}
			}
			
			return bombsCount;
		}
	}

}