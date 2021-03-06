package views {
    import flash.events.MouseEvent;
    import flash.geom.Point;

    import starling.display.Sprite;
    import starling.events.Event;
    import starling.events.KeyboardEvent;
    import starling.display.DisplayObject;
    import feathers.controls.Header;
    import feathers.events.FeathersEventType;
    import feathers.controls.Button;

    import models.Node;
    import models.Grid;
    import ui.NodeButton;
    import events.NavigationEvent;
    import events.GameEvent;

    public class GameView extends Sprite 
    {        
        private var _grid:Grid;
        private var ctrlPressed:Boolean;
        private var remainingBombs:int;
        private var gameDifficulty:int;
        public function GameView(grid:Grid, difficulty:int) 
        {
            super();
            this._grid = grid;
            this.gameDifficulty = difficulty;
            this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
        }
        
        private function onAddedToStage(event:Event):void
        {
            trace("Game screen initialized");
            drawGrid();
            
            var header:Header = new Header();
            header.width = Constants.GameWidth;
            header.title = Constants.DIFFICULTY_NAME[this.gameDifficulty] + " Game";
            this.addChild( header );
            
            var homeBtn:Button = new Button();
            homeBtn.label = "Back to Main Menu";
            homeBtn.addEventListener(Event.TRIGGERED, onHomeBtnTriggered); 
            header.leftItems = new <DisplayObject>[homeBtn];
            
            this.remainingBombs = this._grid.getBombNb();
            var bombCountButton:Button = new Button();
            bombCountButton.label = "Remaining bombs: " + this.remainingBombs.toString();
            bombCountButton.name = "bombCountButton";
            bombCountButton.removeEventListeners();
            header.rightItems = new <DisplayObject> [bombCountButton];
            header.name = "gameHeader";
            
            this.addEventListener(MouseEvent.RIGHT_CLICK, function():void { trace("lol"); } );

            this.addEventListener(KeyboardEvent.KEY_DOWN, updateCtrlKey);
            this.addEventListener(KeyboardEvent.KEY_UP, updateCtrlKey);
        }
        
        private function drawGrid():void
        {
            var gridWidth:int = this._grid.getColNb() * Constants.NODE_DIMENSION;
            var gridHeight:int = this._grid.getRowNb() * Constants.NODE_DIMENSION;
            var startX:Number = (Constants.GameWidth - gridWidth) / 2;
            // 30 is header's height
            var startY:Number = (Constants.GameHeight - gridHeight + 30) / 2;
            for (var col:int = 0; col < this._grid.getColNb(); col++)
            {
                for (var row:int = 0; row < this._grid.getRowNb(); row++)
                {
                    var nodeBtn:NodeButton = new NodeButton(this._grid.getNode(col, row));
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
        
        private function onHomeBtnTriggered(event:Event):void
        {
            this.dispatchEvent(new NavigationEvent(NavigationEvent.CHANGE_SCREEN, true, { id: "home" } ));
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
            if (nodeBtn.getNode().getState() == Node.STATE_FLAGGED)
            {
                // Unflag node
                this.remainingBombs += 1;
                nodeBtn.getNode().setState(Node.STATE_HIDDEN);
                nodeBtn.label = "";
                nodeBtn.updateSkin("delIcon");
            }
            else
            {
                // Flag node
                nodeBtn.getNode().setState(Node.STATE_FLAGGED);
                nodeBtn.updateSkin("flag");
                this.remainingBombs -= 1;
            }
            // update bombCountButton's label
            var header:Header = this.getChildByName("gameHeader") as Header;
            var bombCountButton:Button = header.rightItems[0] as Button;
            bombCountButton.label = "Remaining bombs: " + this.remainingBombs.toString();
            // Strange that we need to do this... Label does not update otherwise
            header.rightItems = new <DisplayObject> [bombCountButton];
        }

        private function revealClick(nodeBtn:NodeButton):void
        {
            if (nodeBtn.getNode().getState() != Node.STATE_FLAGGED)
            {
                if (nodeBtn.getNode().isBomb())
                {
                    // Player looses. Reveals all bombs.
                    revealAllBombs();
                    this.dispatchEvent(new GameEvent(GameEvent.NODE_EVENT, true, { id: "bombNodeRevealed" } ));
                }
                else
                {
                    revealNode(nodeBtn);
                    this.dispatchEvent(new GameEvent(GameEvent.NODE_EVENT, true, { id: "cueNodeRevealed" } ));
                }
            }
            else
            {
                // Button is not pushed if a flag is clicked
                nodeBtn.updateSkin("untoggle");
            }
        }
        
        private function revealNode(nodeBtn:NodeButton):void
        {
            nodeBtn.getNode().setState(Node.STATE_REVEALED);
            var bombCount:int = nodeBtn.getNode().getNeighborBombsCount();
            nodeBtn.label = bombCount == 0 ? "" : bombCount.toString();
            nodeBtn.updateSkin("delIcon");
            // Once a node is revealed, it does not need to listen to events
            nodeBtn.removeEventListeners();

            if (bombCount == 0)
            {
                extendNullNode(nodeBtn.getNode());
            }
        }
        
        private function revealAllBombs():void
        {
            var bombBtn:NodeButton 
            var bombPositions:Array = this._grid.getBombsPos();
            for (var bombIndex:int = 0; bombIndex < bombPositions.length; bombIndex++)
            {
                bombBtn = this.getChildByName(bombPositions[bombIndex].x + ";" + bombPositions[bombIndex].y) as NodeButton;
                bombBtn.getNode().setState(Node.STATE_BOOM);
                bombBtn.updateSkin("bomb");
            }
        }
        
        private function extendNullNode(node:Node):void {
            // reveals all neighbor nodes with no neighbor bomb
            var neighborsArray:Array = node.getNeighborsCoordinates();
            for (var index:int = 0; index < neighborsArray.length; index++)
            {
                var neighborPoint:Point = neighborsArray[index];
                var neighborBtn:NodeButton = this.getChildByName(neighborPoint.x + ";" + neighborPoint.y) as NodeButton;
                if (neighborBtn.getNode().getState() != Node.STATE_REVEALED)
                {
                    neighborBtn.isSelected = true;
                    revealNode(neighborBtn);
                }
            }
        }

    }
}
