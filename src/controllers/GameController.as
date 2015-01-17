package controllers {
    import events.NavigationEvent;
    import events.GameEvent;
    import models.Grid;
    import views.GameView;
    import views.HomeView;
    import ui.NodeButton;
    
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
            
            this.addEventListener(GameEvent.NODE_EVENT, onNodeEvent)
            
            // Initialize the grid and create the game view
            grid = new Grid(20, 15, 40);
            gameScreen = new GameView(grid);
            this.addChild(gameScreen);
        }
        
        private function onChangeScreen(event:NavigationEvent):void
        {
            // Handles every event that should change screen (play game, back to main menu ...)
            switch (event._params.id)
            {
                case "play":
                    newGame();
                    break;
            }
        }
        
        private function onNodeEvent(event:GameEvent):void
        {
            switch (event._params.id)
            {
                case "click":
                    //trace(nodeBtn);
                    //nodeBtn.label = nodeBtn.getNode().getNeighborBombsCount().toString();
                    trace("Node Clicked");
                    break;
            }
        }
    }

}