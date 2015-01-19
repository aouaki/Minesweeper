package views {
    import starling.display.Image;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.text.TextField;

    import feathers.controls.Header;
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
            
            var header:Header = new Header();
            header.width = Constants.GameWidth;
            header.title = "Minesweeper";
            this.addChild( header );
            
            var newGameBtn:Button = new Button();
            newGameBtn.label = "Start new game";
            newGameBtn.x = 315;
            newGameBtn.y = (Constants.GameHeight - newGameBtn.height + 30) / 4;

            this.addChild(newGameBtn);
            
            newGameBtn.addEventListener(Event.TRIGGERED, onNewGameBtnClick);
        }
        
        private function onNewGameBtnClick(event:Event):void
        {
            trace("newGameBtn clicked");
            this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, true, {id: "setupParams"}));
        }
    }

}
