package
{
	import screens.Home;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	public class Game extends Sprite 
	{
		
		private var screenHome:Home;
		public function Game() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			trace("Game initialized");
			screenHome = new Home();
			
			this.addChild(screenHome);
		}
	}

}