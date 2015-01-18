package views 
{
    import starling.events.Event;
    import starling.display.Sprite;

    import feathers.controls.Radio;
    import feathers.controls.Button;
    import feathers.core.ToggleGroup;
    
    import events.NavigationEvent;

    public class GameParamsPopup extends Sprite 
    {
        
        public function GameParamsPopup() 
        {
            super();
            this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }

        private function onAddedToStage():void
        {
            var difficultyGroup:ToggleGroup = new ToggleGroup();
 
            var radio1:Radio = new Radio();
            radio1.label = "Easy";
            radio1.name = Constants.EASY_NAME;
            radio1.y = -50;
            radio1.toggleGroup = difficultyGroup;
            this.addChild( radio1 );
             
            var radio2:Radio = new Radio();
            radio2.label = "Intermediate";
            radio1.name = Constants.INTERMEDIATE_NAME;
            radio2.y = 0;
            radio2.toggleGroup = difficultyGroup;
            this.addChild( radio2 );
             
            var radio3:Radio = new Radio();
            radio3.label = "Hard";
            radio1.name = Constants.HARD_NAME;
            radio3.y = 50;
            radio3.toggleGroup = difficultyGroup;
            this.addChild( radio3 );
            
            var goBtn:Button = new Button();
            goBtn.label = "Go !";
            goBtn.y = 100;
            this.addChild(goBtn);
            
            goBtn.addEventListener(Event.TRIGGERED, onGoClick);
        }
        
        private function onGoClick(event:Event):void
        {
            trace("GoClick");
            this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, true, {id: "play"}));
        }
    }

}

