package screens 
{
	import starling.display.Sprite;
	
	public class GameView extends Sprite 
	{
		
		public function GameView() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
				
		private function onAddedToStage(event:Event):void
		{
			trace("Game screen initialized");
		}

		
	}

}