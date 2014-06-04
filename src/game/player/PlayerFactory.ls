package sprinter.game.player 
{
	import loom.gameframework.LoomGameObject;
	import loom.gameframework.LoomGroup;
	import loom2d.display.DisplayObjectContainer;
	import loom2d.math.Point;
	import sprinter.game.RenderComponent;
	import sprinter.game.InputComponent;
	import sprinter.game.PhysicsComponent;
	import sprinter.game.player.PlayerMovementComponent;
	
	public class PlayerFactory 
	{
		public static function create(parent: DisplayObjectContainer,
									  spawnCoordinates: Point): Player
		{
			var inputComponent = new InputComponent(parent.stage);
			var physicsComponent = new PhysicsComponent(new Point(0, 0), spawnCoordinates);
			var movementComponent = new PlayerMovementComponent(physicsComponent);
			var renderComponent = new RenderComponent(parent, spawnCoordinates, "ball.png");
			
			return PlayerBuilder.create()
								.withInput(inputComponent)
								.withPhysics(physicsComponent)
								.withMover(movementComponent)
								.withRenderer(renderComponent)
								.build();
		}	
	}
}