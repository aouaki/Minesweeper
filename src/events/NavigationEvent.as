package events 
{
	import starling.events.Event;
	
	public class NavigationEvent extends Event 
	{
		public static const CHANGE_SCREEN:String = "changeScreen";
		public var _params:Object;
		public function NavigationEvent(type:String, bubbles:Boolean=false, params:Object=null) 
		{
			super(type, bubbles, data);
			this._params = params;
		}
		
	}

}