package controllers {
	import events.NavigationEvent;
	import models.Grid;
	import views.GameView;
	import views.HomeView;
	
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import feathers.themes.MinimalDesktopTheme;

	public class GameController extends Sprite 
	{
		private var gameScreen:GameView;
		private var homeScreen:HomeView;
		private var grid:Grid;
		
		public function GameController() 
		{
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(event:Event):void
		{
			new MinimalDesktopTheme();
			trace("Game initialized");
			this.addEventListener(NavigationEvent.CHANGE_SCREEN, onChangeScreen);
			
			homeScreen = new HomeView();
			this.addChild(homeScreen);
		}
		
		private function newGame():void
		{
			if (this.homeScreen != null)
			{
				this.removeChild(homeScreen);
			}
			
			grid = new Grid(20, 20, 10);
			gameScreen = new GameView(grid);
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