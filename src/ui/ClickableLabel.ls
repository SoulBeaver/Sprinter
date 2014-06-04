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