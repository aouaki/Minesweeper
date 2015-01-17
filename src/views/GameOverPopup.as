package views 
{
    import starling.display.Sprite;
    import starling.events.Event;
    import feathers.controls.Button;
    
    import events.NavigationEvent;
    
    public class GameOverPopup extends Sprite 
    {
        
        private var gameOverBtn:Button;
        private var replayBtn:Button;
        private var replayList:PickerList;
        private var exitBtn:Button;
        public function GameOverPopup() 
        {
            super();
            this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }

        private function onAddedToStage(event:Event):void
        {
            trace("Game Over screen initialized");

            drawGameOverScreen();
        }
            
        private function drawGameOverScreen():void
        {
            gameOverBtn = new Button();
            gameOverBtn.label = "Game Over !"
            this.addChild(gameOverBtn);
            
            replayBtn = new Button();
            replayBtn.label = "New Game";
            replayBtn.y = 300;
            this.addChild(replayBtn);
            
            exitBtn = new Button();
            exitBtn.label = "Quit";
            exitBtn.y = 400;
            //this.addChild(exitBtn);
            //exitBtn.addEventListener(Event.TRIGGERED, onExitBtnClick);
        }
        
        private function onReplayBtnClick(event:Event):void
        {
            this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, true, {id: "play"}));
        }
        
        private function onExitBtnClick(event:Event):void
        {
            this.dispatchEvent(new NavigationEvent(NavigationEvent.QUIT_GAME, true, {id: "exit"}));
        }
        
    }

}

