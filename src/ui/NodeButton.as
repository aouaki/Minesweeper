package ui 
{
    import feathers.controls.ToggleButton;
    import models.Node;
    import starling.events.Event;
    
    public class NodeButton extends ToggleButton 
    {
        private var _node:Node;
        
        public function NodeButton(node:Node) 
        {
            super();
            this._node = node;
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
        
    }

}
