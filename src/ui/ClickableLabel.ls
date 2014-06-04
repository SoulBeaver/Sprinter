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

package sprinter.ui 
{
	import loom2d.display.Sprite;
	import loom2d.events.TouchEvent;
	import loom2d.events.TouchPhase;
	import loom2d.ui.ButtonClickCallback;
	import loom2d.ui.SimpleLabel;
	
public class ClickableLabel extends SimpleLabel
{
	public var onClick: ButtonClickCallback;
	
	public function ClickableLabel() 
	{
		super();
		
		touchable = true;
		addEventListener(TouchEvent.TOUCH, onTouchDown);
	}
	
	protected function onTouchDown(e: TouchEvent, ignore: Object)
	{
		if (e.getTouch(this, TouchPhase.ENDED))
		{
			e.stopPropagation();
			onClick();
		}
	}
}
	
}