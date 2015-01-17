package
{
    import flash.display.Sprite;
    import flash.events.Event;

    import starling.core.Starling;

    import controllers.GameController;

    [SWF(width="400", height="300", frameRate="60", backgroundColor="0xdddddd")]
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
            _starling = new Starling(GameController, stage);
            _starling.antiAliasing = 1;
            _starling.start();
        }
    }
}