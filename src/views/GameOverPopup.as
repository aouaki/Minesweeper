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
            replayBtn.addEventListener(Event.TRIGGERED, onReplayBtnClick);
            
        }
        
        private function onReplayBtnClick(event:Event):void
        {
            this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, true, {id: "setupParams"}));
        }
        
    }

}

