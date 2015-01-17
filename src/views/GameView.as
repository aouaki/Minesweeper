package views {
    import feathers.events.FeathersEventType;
    import flash.geom.Point;
    import models.Node;
    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.KeyboardEvent;

    import feathers.controls.Button;
    import ui.NodeButton;

    import models.Grid;
    import events.GameEvent;

    public class GameView extends Sprite 
    {        
        private var grid:Grid;
        private var ctrlPressed:Boolean;
        private var remainingBombs:int;
        
        public function GameView(_grid:Grid) 
        {
            super();
            this.grid = _grid;
            this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }
        
        private function onAddedToStage(event:Event):void
        {
            trace("Game screen initialized");
            drawGrid();
            
            this.remainingBombs = this.grid.getBombNb();
            var bombCountButton:Button = new Button();
            bombCountButton.label = this.remainingBombs.toString();
            bombCountButton.name = "bombCountButton";
            this.addChild(bombCountButton);

            this.addEventListener(KeyboardEvent.KEY_DOWN, updateCtrlKey);
            this.addEventListener(KeyboardEvent.KEY_UP, updateCtrlKey);
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
                    nodeBtn.y = 30 + y * 20;
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
            if (nodeBtn.getNode().getState() == Node.STATE_FLAGGED)
            {
                this.remainingBombs += 1;
                nodeBtn.getNode().setState(Node.STATE_HIDDEN);
                nodeBtn.label = "";
            }
            else
            {
                nodeBtn.getNode().setState(Node.STATE_FLAGGED);
                nodeBtn.label = "F";
                this.remainingBombs -= 1;
                var bombCountButton:Button = this.getChildByName("bombCountButton") as Button;
                bombCountButton.label = this.remainingBombs.toString();
            }
            this.dispatchEvent(new GameEvent(GameEvent.NODE_EVENT, true, { id: "flagClick" } ));
        }

        private function clickNode(nodeBtn:NodeButton):void
        {
            nodeBtn.getNode().setState(Node.STATE_REVEALED);
            if (nodeBtn.getNode().isBomb())
            {
                nodeBtn.label = "B";
                this.dispatchEvent(new GameEvent(GameEvent.NODE_EVENT, true, { id: "bombClick" } ));
            }
            else
            {
                var bombCount:int = nodeBtn.getNode().getNeighborBombsCount();
                nodeBtn.label = bombCount == 0 ? "" : bombCount.toString();
                if (bombCount == 0)
                {
                    extendNullNode(nodeBtn.getNode());
                }
                this.dispatchEvent(new GameEvent(GameEvent.NODE_EVENT, true, { id: "cueClick" } ));
            }
            
            // Once a node is clicked, interactions with it are disabled
            nodeBtn.removeEventListeners();
        }
        
        private function extendNullNode(node:Node):void {
            var neighborsArray:Array = node.getNeighborsCoordinates();
            for (var index:int = 0; index < neighborsArray.length; index++)
            {
                var neighborPoint:Point = neighborsArray[index];
                var neighborBtn:NodeButton = this.getChildByName(neighborPoint.x + ";" + neighborPoint.y) as NodeButton;
                if (neighborBtn.getNode().getState() != Node.STATE_REVEALED)
                {
                    neighborBtn.setDown();
                    clickNode(neighborBtn);
                }
            }
        }
    }
}