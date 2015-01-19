package ui 
{
    import starling.display.Image;
    import starling.display.Quad;
    import starling.events.Event;
    import feathers.controls.Button;
    import feathers.controls.ToggleButton;
    
    import events.GameEvent;
    import models.Node;
    
    public class NodeButton extends ToggleButton 
    {
        private var _node:Node;
        private var _nodeState:String;
        
        public function NodeButton(node:Node) 
        {
            super();
            this._node = node;
            this.iconPosition = Button.ICON_POSITION_TOP;

        }
        
        public function updateSkin(state:String):void
        {
            switch(state) 
            {
                case "flag":
                    this.defaultIcon = new Image(Assets.getTexture("FlagIcon"));
                    break;
                case "delIcon":
                    // In case the node was flagged while revealed
                    this.defaultIcon = null;
                    break;
                case "bomb":
                    // if you see this icon you're bad
                    this.defaultIcon = new Image(Assets.getTexture("BombIcon"));
                    break;
                case "unrevealed":
                    // Button not pushed if clicked while flagged
                    this.isSelected = false;
                    break;
            }
        }
        
        
        public function getNode():Node
        {
            return this._node;
        }
        
    }

}
