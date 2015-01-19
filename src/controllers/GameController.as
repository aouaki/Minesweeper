package controllers {
    
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.text.TextField;

    import feathers.themes.AeonDesktopTheme;
    import feathers.controls.Button;
    import feathers.core.PopUpManager;

    import models.Grid;
    import ui.NodeButton;
    import events.NavigationEvent;
    import events.GameEvent;
    import views.GameView;
    import views.HomeView;
    import views.GameOverPopup;
    import views.GameParamsPopup;

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
            new AeonDesktopTheme();
            trace("Game initialized");
            this.addEventListener(NavigationEvent.CHANGE_SCREEN, onChangeScreen);
            displayHomeScreen();
        }
        
        private function displayHomeScreen():void
        {
            for (var index:int = 0; index < this.popups.length; index++)
            {
                PopUpManager.removePopUp(this.popups[index])
            }
            this.removeChildren();

            this.popups = []
            homeScreen = new HomeView();
            this.addChild(homeScreen);
        }
        
        private function newGame(difficultyIndex:int):void
        {
            for (var index:int = 0; index < this.popups.length; index++)
            {
                PopUpManager.removePopUp(this.popups[index])
            }

            this.popups = [];
            this.removeChildren();

            trace("New Game");

            var gameDimensions:Array = Constants.DIMENSIONS[difficultyIndex];

            // Initialize the grid and create the game view
            grid = new Grid(gameDimensions[0], gameDimensions[1], gameDimensions[2]);
            gameScreen = new GameView(grid, difficultyIndex);
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
            var eventParams:Object = event.getParams();
            switch (eventParams.id)
            {
                case "home":
                    displayHomeScreen();
                    break;
                case "setupParams":
                    gameParametersPopup();
                    break;
                case "play":
                    newGame(eventParams.difficulty);
                    break;
            }
        }
        
        private function onNodeEvent(event:GameEvent):void
        {
            var gameOverScreen:Sprite;
            switch (event.getParams().id)
            {
                case "cueNodeRevealed":
                    if (this.grid.checkAllNodesRevealed())
                    {
                        gameOverScreen = new GameOverPopup(Constants.WIN);
                        PopUpManager.addPopUp(gameOverScreen);
                        this.popups.push(gameOverScreen);
                        gameOverScreen.addEventListener(NavigationEvent.CHANGE_SCREEN, onChangeScreen);
                    }
                    break;
                case "bombNodeRevealed":
                    gameOverScreen = new GameOverPopup(Constants.LOOSE);
                    PopUpManager.addPopUp(gameOverScreen);
                    this.popups.push(gameOverScreen);
                    gameOverScreen.addEventListener(NavigationEvent.CHANGE_SCREEN, onChangeScreen);
                    break;
            }
        }
    }

}
