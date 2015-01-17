package ui 
{
	import feathers.controls.ToggleButton;
	import models.Node;
	
	public class NodeButton extends ToggleButton 
	{
		private var _node:Node;
		
		public function NodeButton(node:Node) 
		{
			super();
			this._node = node;
		}
		
		public function getNode():Node
		{
			return this._node;
		}
		
	}

}