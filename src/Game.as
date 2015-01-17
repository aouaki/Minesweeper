package
{
	import events.NavigationEvent;
	import screens.GameView;
	import screens.HomeView;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import feathers.themes.MinimalDesktopTheme;

	public class Game extends Sprite 
	{
		private var gameScreen:GameView;
		private var homeScreen:HomeView;
		public function Game() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			new MinimalDesktopTheme();
			trace("Game initialized");
			this.addEventListener(NavigationEvent.CHANGE_SCREEN, onChangeScreen);
			gameScreen = new GameView;
			this.addChild(gameScreen);
			
			homeScreen = new HomeView();
			this.addChild(homeScreen);
		}
		
		private function newGame():void
		{
			if (this.homeScreen != null)
			{
				this.removeChild(homeScreen);
			}
			
			gameScreen = new GameView();
			this.addChild(gameScreen);
			
		}
		
		private function onChangeScreen(event:NavigationEvent):void
		{
			switch (event.params.id)
			{
				case "play":
					newGame();
					break;
			}
		}
	}

}