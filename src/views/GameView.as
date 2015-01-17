package views {	
	import starling.display.Sprite;
	import starling.events.Event;

	import feathers.controls.togglebutton;
	import feathers.controls.Button;

	import models.Grid;
	import events.GameEvent;

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
			trace(this.grid.getRowNb().toString())
			drawGrid();
		}
		
		private function drawGrid():void
		{
			for (var x:int = 0; x < this.grid.getRowNb(); x++)
			{
				for (var y:int = 0; y < this.grid.getColNb(); y++)
				{
					var nodeBtn:ToggleButton = new ToggleButton();
					nodeBtn.width = 25;
					nodeBtn.height = 25;
					nodeBtn.x = x*20;
					nodeBtn.y = y * 20;
					//nodeBtn.label = this.grid.getNode(x, y).getNeighborBombsCount().toString();
					this.addChild(nodeBtn);
					nodeBtn.addEventListener(Event.TRIGGERED, onNodeClick)
					//trace(this.grid.getNode(x, y).getNeighborBombsCount());
				}
			}
		}
		
		private function onNodeClick(event:Event):void
		{
			trace("Node clicked")
			this.dispatchEvent(new GameEvent(GameEvent.NODE_EVENT, true, {id: "click"}));
		}
		
	}

}