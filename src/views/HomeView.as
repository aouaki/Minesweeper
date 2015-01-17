package views {
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;

	import feathers.controls.Button;
	
	import events.NavigationEvent;

	public class HomeView extends Sprite 
	{
		
		private var newGameBtn:Button;

		public function HomeView() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		
		private function onAddedToStage(event:Event):void
		{
			trace("Home screen initialized");
			
			drawHomeScreen();
		}
		
		private function drawHomeScreen():void
		// Draws home screen (Title + New Game btn)
		{
			var background:Image = new Image(Assets.getTexture("HomeBg"));
			this.addChild(background);
			
			var homeTitle:TextField = new TextField(Constants.GameWidth, Constants.GameHeight / 5, "Mine Sweeper", "Verdana", 36, 0x022139);
			this.addChild(homeTitle);
			
			var newGameBtn:Button = new Button();
			newGameBtn.label = "Start new game";
			this.addChild(newGameBtn);
			
			newGameBtn.addEventListener(Event.TRIGGERED, onNewGameBtnClick);

		}
		
		private function onNewGameBtnClick(event:Event):void
		{
			trace("newGameBtn clicked");
			this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, true, {id: "play"})); 
		}
	}

}