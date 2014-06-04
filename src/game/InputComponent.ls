package sprinter.game 
{
	import loom.gameframework.LoomComponent;
	import loom2d.display.DisplayObjectContainer;
	import loom2d.events.Touch;
	import loom2d.events.TouchEvent;
	import loom2d.events.TouchPhase;
	
	public class InputComponent extends LoomComponent
	{
		private var _parent: DisplayObjectContainer;
		
		public var isTouching: Boolean;
		
		public function InputComponent(parent: DisplayObjectContainer)
		{
			_parent = parent;
			
			_parent.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e: TouchEvent)
		{
			isTouching = !e.getTouch(_parent, TouchPhase.ENDED);
			
			if (isTouching)
				Debug.print("We are touching...");
			else
				Debug.print("NO MORE TOUCHING!");
		}
	}
	
}