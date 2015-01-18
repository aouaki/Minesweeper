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
            var gridWidth:int = this.grid.getColNb() * Constants.NODE_DIMENSION;
            var startX:Number = (Constants.GameWidth - gridWidth) / 2;
            var startY:Number = 30;
            trace(startX);
            for (var col:int = 0; col < this.grid.getColNb(); col++)
            {
                for (var row:int = 0; row < this.grid.getRowNb(); row++)
                {
                    var nodeBtn:NodeButton = new NodeButton(this.grid.getNode(col, row));
                    nodeBtn.width = Constants.NODE_DIMENSION;
                    nodeBtn.height = Constants.NODE_DIMENSION;
                    nodeBtn.x = startX + col * Constants.NODE_DIMENSION;
                    nodeBtn.y = startY + row * Constants.NODE_DIMENSION;
                    nodeBtn.name = col + ";" + row;
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
                flagClick (nodeBtn);
            }
            else
            {
                revealClick(nodeBtn);
            }
        }
        
        private function flagClick(nodeBtn:NodeButton):void
        {
            if (nodeBtn.getState() == NodeButton.STATE_FLAGGED)
            {
                // Unflag node
                this.remainingBombs += 1;
                nodeBtn.setState(NodeButton.STATE_HIDDEN);
                nodeBtn.label = "";
            }
            else
            {
                // Flag node
                nodeBtn.setState(NodeButton.STATE_FLAGGED);
                nodeBtn.label = "F";
                this.remainingBombs -= 1;
                this.dispatchEvent(new GameEvent(GameEvent.NODE_EVENT, true, { id: "flagSet" } ));

            }
            // update bombCountButton's label
            var bombCountButton:Button = this.getChildByName("bombCountButton") as Button;
            bombCountButton.label = this.remainingBombs.toString();
        }

        private function revealClick(nodeBtn:NodeButton):void
        {
            if (nodeBtn.getState() != NodeButton.STATE_FLAGGED)
            {
                if (nodeBtn.getNode().isBomb())
                {
                    nodeBtn.setState(NodeButton.STATE_BOOM);
                    nodeBtn.label = "B";
                    this.dispatchEvent(new GameEvent(GameEvent.NODE_EVENT, true, { id: "bombNodeRevealed" } ));
                }
                else
                {
                    nodeBtn.setState(NodeButton.STATE_REVEALED);
                    var bombCount:int = nodeBtn.getNode().getNeighborBombsCount();
                    trace(bombCount.toString());
                    nodeBtn.label = bombCount == 0 ? "" : bombCount.toString();
                    if (bombCount == 0)
                    {
                        extendNullNode(nodeBtn.getNode());
                    }
                    this.dispatchEvent(new GameEvent(GameEvent.NODE_EVENT, true, { id: "cueNodeRevealed" } ));
                }
                
                // Once a node is clicked, interactions with it are disabled
                nodeBtn.removeEventListeners();
            }
        }
        
        private function extendNullNode(node:Node):void {
            var neighborsArray:Array = node.getNeighborsCoordinates();
            for (var index:int = 0; index < neighborsArray.length; index++)
            {
                var neighborPoint:Point = neighborsArray[index];
                var neighborBtn:NodeButton = this.getChildByName(neighborPoint.x + ";" + neighborPoint.y) as NodeButton;
                if (neighborBtn.getState() != NodeButton.STATE_REVEALED)
                {
                    neighborBtn.setDown();
                    revealClick(neighborBtn);
                }
            }
        }

    }
}
