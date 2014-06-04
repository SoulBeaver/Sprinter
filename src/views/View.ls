package sprinter.views 
{
	import loom2d.display.DisplayObjectContainer;
	import loom2d.display.Stage;
	
	public delegate ViewCallback(): void;
	
	public class View extends DisplayObjectContainer
	{
		public var onEnter: ViewCallback;
		public var onExit: ViewCallback;
		
		public function enter(stage: Stage)
		{
			stage.addChild(this);
			
			onEnter();
		}
		
		public function exit()
		{
			if (parent)	parent.removeChild(this);
			
			onExit();
		}
	}
	
}