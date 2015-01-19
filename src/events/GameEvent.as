package events 
{
    import starling.events.Event;
    
    public class GameEvent extends Event 
    {
        // Event used to check if the player has won or lost
        // Happens when a bomb or a cueNode is revealed
        public static const NODE_EVENT:String = "nodeEvent";
        private var _params:Object;
        public function GameEvent(type:String, bubbles:Boolean=false, params:Object=null) 
        {
            super(type, bubbles, data);
            this._params = params;
        }

        public function getParams():Object
        {
            return this._params;
        }
    }

}
