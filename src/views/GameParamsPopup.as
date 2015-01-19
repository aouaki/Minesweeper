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
        private var difficultyGroup:ToggleGroup;
        
        public function GameParamsPopup() 
        {
            super();
            this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }

        private function onAddedToStage():void
        {
            difficultyGroup = new ToggleGroup();
 
            var radio_easy:Radio = new Radio();
            radio_easy.label = "Easy";
            radio_easy.x = -16;
            radio_easy.y = 0;
            radio_easy.toggleGroup = difficultyGroup;
            this.addChild(radio_easy);
             
            var radio_intermediate:Radio = new Radio();
            radio_intermediate.label = "Intermediate";
            radio_intermediate.x = -16;
            radio_intermediate.y = 50;
            radio_intermediate.toggleGroup = difficultyGroup;
            this.addChild(radio_intermediate);
             
            var radio_hard:Radio = new Radio();
            radio_hard.label = "Hard";
            radio_hard.x = -16;
            radio_hard.y = 100;
            radio_hard.toggleGroup = difficultyGroup;
            this.addChild(radio_hard);
            
            var goBtn:Button = new Button();
            goBtn.label = "Go !";
            goBtn.x = -22;
            goBtn.y = 200;
            this.addChild(goBtn);
            
            goBtn.addEventListener(Event.TRIGGERED, onGoClick);
        }
        
        private function onGoClick(event:Event):void
        {
            trace("GoClick");
            this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, true, {id: "play", difficulty: this.difficultyGroup.selectedIndex}));
        }
    }

}

