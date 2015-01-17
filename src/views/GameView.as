package views {
	import feathers.controls.Button;
	import models.Grid;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class GameView extends Sprite 
	{		
		private var grid:Grid;
		
		public function GameView(_grid:Grid) 
		{
			super();
			this.grid = _grid;
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			trace("Game screen initialized");
			trace(this.grid.getRowNb().toString());
			for (var x:int = 0; x < this.grid.getRowNb(); x++)
			{
				for (var y:int = 0; y < this.grid.getColNb(); y++)
				{
					var nodeBtn:Button = new Button();
					nodeBtn.label = this.grid.getNode(x, y).getNeighborBombsCount().toString();
					this.addChild(nodeBtn);
					//trace(this.grid.getNode(x, y).getNeighborBombsCount());
				}
			}
		}

		
	}

}