package screens
{
	import feathers.controls.Button;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	
	public class Home extends Sprite 
	{
		
		public function Home() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		
		private function onAddedToStage(event:Event):void
		{
			trace("Home screen initialized");
			
			drawScreen();
		}
		
		private function drawScreen():void
		// Draws home screen (Title + New Game btn)
		{
			var background:Image = new Image(Assets.getTexture("HomeBg"));
			this.addChild(background);
			
			var homeTitle:TextField = new TextField(Constants.GameWidth, Constants.GameHeight / 5, "Mine Sweeper", "Verdana", 36, 0x022139);
			this.addChild(homeTitle);
			
			var newGameBtn:Button = new Button();
			this.addChild(newGameBtn);
		}
	}

}