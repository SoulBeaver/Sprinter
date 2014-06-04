/*
Copyright 2014 Christian Broomfield

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

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