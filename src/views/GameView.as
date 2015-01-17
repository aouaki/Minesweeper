package views {
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.KeyboardEvent;

    import ui.NodeButton;
    import feathers.controls.Button;

    import models.Grid;
    import events.GameEvent;

    public class GameView extends Sprite 
    {        
        private var grid:Grid;
        private var ctrlPressed:Boolean;
        
        public function GameView(_grid:Grid) 
        {
            super();
            this.grid = _grid;
            this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }
        
        private function onAddedToStage(event:Event):void
        {
            trace("Game screen initialized");
            trace(this.grid.getRowNb().toString());
            this.addEventListener(KeyboardEvent.KEY_DOWN, updateCtrlKey);
            this.addEventListener(KeyboardEvent.KEY_UP, updateCtrlKey);
            drawGrid();
        }
        
        private function drawGrid():void
        {
            for (var x:int = 0; x < this.grid.getRowNb(); x++)
            {
                for (var y:int = 0; y < this.grid.getColNb(); y++)
                {
                    var nodeBtn:NodeButton = new NodeButton(this.grid.getNode(x, y));
                    // TODO : Use constants
                    nodeBtn.width = 25;
                    nodeBtn.height = 25;
                    nodeBtn.x = x * 20;
                    nodeBtn.y = y * 20;
                    this.addChild(nodeBtn);
                    nodeBtn.addEventListener(Event.TRIGGERED, onNodeClick);
                }
            }
        }
        
        private function updateCtrlKey(event:KeyboardEvent):void
        {
            this.ctrlPressed = event.ctrlKey;
        }
        
        private function onNodeClick(event:Event):void
        {
            var nodeBtn:NodeButton = event.target as NodeButton;
            if (this.ctrlPressed)
            {
                trace("Node rightclicked");
                nodeBtn.label = "F";
                this.dispatchEvent(new GameEvent(GameEvent.NODE_EVENT, true, { id: "ctrlClick" } ));
            }
            else
            {
                trace("Node clicked");
                if (nodeBtn.getNode().isBomb())
                {
                    // Should fire an event "you loose"
                    nodeBtn.label = "B";
                }
                else
                {
                    // Should fire an event "test win"
                    nodeBtn.label = nodeBtn.getNode().getNeighborBombsCount().toString();    
                }
                
                // Once a node is clicked, interactions with it are disabled
                nodeBtn.removeEventListeners();
                this.dispatchEvent(new GameEvent(GameEvent.NODE_EVENT, true, { id: "click" } ));
            }
        }
        
    }
}
