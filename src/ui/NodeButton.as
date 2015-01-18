package ui 
{
    import feathers.controls.ToggleButton;
    import models.Node;
    import starling.events.Event;
    
    import events.GameEvent;
    
    public class NodeButton extends ToggleButton 
    {
        private var _node:Node;
        private var _nodeState:String;
        
        public static const STATE_FLAGGED:String = "flagged";
        public static const STATE_REVEALED:String = "revealed";
        public static const STATE_HIDDEN:String = "hidden";
        public static const STATE_BOOM:String = "boom";
        
        public function NodeButton(node:Node) 
        {
            super();
            this._node = node;
            this._nodeState = STATE_HIDDEN;
        }
        
        public function setDown():void
        {
            // Necessary for null nodes automatically toggling their neighbors when clicked.
            this.trigger();
        }
        
        
        public function getNode():Node
        {
            return this._node;
        }
                
        public function getState():String
        {
            return this._nodeState;
        }
        
        
        public function setState(state:String):void
        {
            this._nodeState = state;
        }

    }

}
