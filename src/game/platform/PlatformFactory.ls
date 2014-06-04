package sprinter.game.platform 
{
	import loom.gameframework.LoomGameObject;
	import loom2d.display.DisplayObjectContainer;
	import loom2d.math.Point;
	import sprinter.game.PhysicsComponent;
	import sprinter.game.RenderComponent;
	import sprinter.util.Coin;
	
	public class PlatformFactory 
	{
		public static function create(parent: DisplayObjectContainer,
									  spawnPosition: Point): LoomGameObject
	    {
			var platform = new LoomGameObject();
			
			var renderComponent = new RenderComponent(parent, 
													  spawnPosition,
													  (Coin.flip() ? "redpaddle.png" : "bluepaddle.png"));
			platform.addComponent(renderComponent, "rendering");
			
			platform.initialize();
			
			return platform;
	    }
	}
	
}