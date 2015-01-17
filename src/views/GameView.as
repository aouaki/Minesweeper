package views {
    import models.Node;
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
            this.addEventListener(KeyboardEvent.KEY_DOWN, updateCtrlKey);
            this.addEventListener(KeyboardEvent.KEY_UP, updateCtrlKey);
            drawGrid();
        }
        
        private function drawGrid():void
        {
            for (var x:int = 0; x < this.grid.getColNb(); x++)
            {
                for (var y:int = 0; y < this.grid.getRowNb(); y++)
                {
                    var nodeBtn:NodeButton = new NodeButton(this.grid.getNode(x, y));
                    // TODO : Use constants
                    nodeBtn.width = 25;
                    nodeBtn.height = 25;
                    nodeBtn.x = x * 20;
                    nodeBtn.y = y * 20;
                    nodeBtn.name = x + ";" + y;
                    this.addChild(nodeBtn);
                    nodeBtn.addEventListener(Event.TRIGGERED, onNodeTrigger);
                }
            }
        }
        
        private function updateCtrlKey(event:KeyboardEvent):void
        {
            this.ctrlPressed = event.ctrlKey;
        }
        
        private function onNodeTrigger(event:Event):void
        {
            var nodeBtn:NodeButton = event.target as NodeButton;
            if (this.ctrlPressed)
            {
                flagNode(nodeBtn);
            }
            else
            {
                clickNode(nodeBtn);
            }
        }
        
        private function flagNode(nodeBtn:NodeButton):void
        {
            nodeBtn.getNode().setState(Node.STATE_FLAGGED);
            nodeBtn.label = "F";
            this.dispatchEvent(new GameEvent(GameEvent.NODE_EVENT, true, { id: "flagClick" } ));
        }

        private function clickNode(nodeBtn:NodeButton):void
        {
            trace("ClickNode");
            nodeBtn.getNode().setState(Node.STATE_REVEALED);
            if (nodeBtn.getNode().isBomb())
            {
                // Should fire an event "you loose"
                nodeBtn.label = "B";
                this.dispatchEvent(new GameEvent(GameEvent.NODE_EVENT, true, { id: "bombClick" } ));
            }
            else
            {
                // TODO : Test if win
                var bombCount:int = nodeBtn.getNode().getNeighborBombsCount();
                //nodeBtn.label = bombCount == 0 ? "" : bombCount.toString();
                nodeBtn.label = bombCount.toString();
                if (bombCount == 0)
                {
                    var neighborCoordinates:Array = nodeBtn.getNode().getNeighborsCoordinates();
                    for (var index:int = 0; index < neighborCoordinates.length; index++)
                    {
                        var neighborBtn:NodeButton = this.getChildByName(neighborCoordinates[index].x + ";" + neighborCoordinates[index].y) as NodeButton;
                        if (neighborBtn.getNode().getState() != Node.STATE_REVEALED)
                        {
                            clickNode(neighborBtn);
                        }
                    }
                }
                this.dispatchEvent(new GameEvent(GameEvent.NODE_EVENT, true, { id: "cueClick" } ));
            }
            
            // Once a node is clicked, interactions with it are disabled
            nodeBtn.removeEventListeners();
        }
    }
}
