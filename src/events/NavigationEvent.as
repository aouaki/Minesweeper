package events 
{
    import starling.events.Event;
    
    public class NavigationEvent extends Event 
    {
        public static const CHANGE_SCREEN:String = "changeScreen";
        private var _params:Object;
        public function NavigationEvent(type:String, bubbles:Boolean=false, params:Object=null) 
        {
            super(type, bubbles, params);
            this._params = params;
        }
        
        public function getParams():Object
        {
            return this._params;
        }
        
    }

}
