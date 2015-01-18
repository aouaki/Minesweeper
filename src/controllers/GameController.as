package controllers {
    import events.NavigationEvent;
    import events.GameEvent;
    import feathers.controls.Button;
    import feathers.core.PopUpManager;
    import models.Grid;
    import starling.display.DisplayObject;
    import ui.NodeButton;
    import views.GameView;
    import views.HomeView;
    import views.GameOverPopup;
    import views.GameParamsPopup;
    
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.text.TextField;
    import feathers.themes.MinimalDesktopTheme;

    public class GameController extends Sprite 
    {
        private var gameScreen:GameView;
        private var homeScreen:HomeView;
        private var grid:Grid;
        private var popups:Array = [];
        
        
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
            for (var index:int = 0; index < this.popups.length; index++)
            {
                PopUpManager.removePopUp(this.popups[index])
            }

            this.popups = []
            
            trace("New Game");
            if (this.homeScreen != null)
            {
                this.removeChild(homeScreen);
            }
            
            if (this.gameScreen != null)
            {
                this.removeChild(gameScreen);
            }
            
            // Initialize the grid and create the game view
            // TODO : Implement game difficulties (predefined, then add custom)
            grid = new Grid(20, 20, 40);
            gameScreen = new GameView(grid);
            this.addChild(gameScreen);

            this.addEventListener(GameEvent.NODE_EVENT, onNodeEvent);
        }
        
        private function gameParametersPopup():void
        {
            var gameParamsScreen:Sprite = new GameParamsPopup();
            PopUpManager.addPopUp(gameParamsScreen);
            this.popups.push(gameParamsScreen);
            gameParamsScreen.addEventListener(NavigationEvent.CHANGE_SCREEN, onChangeScreen);

        }
        
        private function onChangeScreen(event:NavigationEvent):void
        {
            trace("Change Screen");
            // Handles every event that should change screen (play game, back to main menu, replay ...)
            switch (event._params.id)
            {
                case "setupParams":
                    gameParametersPopup();
                    break;
                case "play":
                    newGame();
                    break;
            }
        }
        
        private function onNodeEvent(event:GameEvent):void
        {
            switch (event._params.id)
            {
                case "flagSet":
                    // TODO : Update remaining bombs count
                    // trace("flagClick");
                    break;
                case "cueNodeRevealed":
                    // TODO : Check if win all cueNodes are revealed
                    // trace("cueClick");
                    break;
                case "bombNodeRevealed":
                    var gameOverScreen:Sprite = new GameOverPopup();
                    PopUpManager.addPopUp(gameOverScreen);
                    this.popups.push(gameOverScreen);
                    gameOverScreen.addEventListener(NavigationEvent.CHANGE_SCREEN, onChangeScreen);
                    trace("popup Added");
                    break;
            }
        }
    }

}
