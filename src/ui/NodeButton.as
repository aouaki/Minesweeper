package ui 
{
    import feathers.controls.Button;
    import feathers.controls.ToggleButton;
    import models.Node;
    import starling.display.Image;
    import starling.display.Quad;
    import starling.events.Event;
    
    import events.GameEvent;
    
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
        
        public function setDown():void
        {
            // Necessary for null nodes automatically toggling their neighbors when clicked.
            this.trigger();
        }
        
        public function updateSkin(state:String):void
        {
            switch(state) 
            {
                case "flag":
                    this.defaultIcon = new Image(Assets.getTexture("FlagIcon"));
                    break;
                case "bomb":
                    this.defaultIcon = new Image(Assets.getTexture("BombIcon"));
                    break;
                case "untoggled":
                this.defaultIcon = null;
                break;
            }
        }
        
        
        public function getNode():Node
        {
            return this._node;
        }
        
    }

}
