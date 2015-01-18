package events 
{
    import starling.events.Event;
    
    public class GameEvent extends Event 
    {
        public static const NODE_EVENT:String = "nodeEvent";
        public var _params:Object;
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
