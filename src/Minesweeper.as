package
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;

    import starling.core.Starling;

    import controllers.GameController;

    [SWF(width="700", height="730", frameRate="60")]
    public class Minesweeper extends Sprite
    {
        private var _starling:Starling;

        public function Minesweeper()
        {
            super();
            this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }
        
        private function onAddedToStage(event:Event):void
        {
            stage.addEventListener(MouseEvent.RIGHT_CLICK, function():void { return; } );
            _starling = new Starling(GameController, stage);
            _starling.antiAliasing = 1;
            _starling.start();
        }
    }
}
