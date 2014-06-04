package sprinter.views 
{
	import loom.gameframework.LoomGroup;
	import sprinter.game.SprintLevel;
	import loom2d.Loom2D;
	import loom2d.display.DisplayObjectContainer;
	import loom2d.display.Stage;
	
	public class GameView extends View
	{
		public var level: SprintLevel;
		public var group: LoomGroup;
		
		public function enter(stage: Stage)
		{
			super.enter(stage);
			
			Debug.assert(!level, "The level was alread initialized.");

			level = new SprintLevel();
			level.owningGroup = group;
			level.create(stage);
		}
		
		public function exit()
		{
			Debug.assert(level, "The level was never initialized.");
			
			level.destroy();
			level = null;
			
			super.exit();
		}
	}
	
}