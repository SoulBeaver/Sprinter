package sprinter.game.player 
{
	import loom.gameframework.LoomGameObject;
	import loom2d.math.Point;
	import loom2d.math.Rectangle;
	import sprinter.game.InputComponent;
	import sprinter.game.PhysicsComponent;
	import sprinter.game.player.PlayerMovementComponent;
	import sprinter.game.RenderComponent;
	
	public class Player extends LoomGameObject
	{
		private var _inputComponent: InputComponent;
		private var _physicsComponent: PhysicsComponent;
		private var _movementComponent: PlayerMovementComponent;
		private var _renderComponent: RenderComponent;
		
		public function Player(builder: PlayerBuilder)
		{			
			_inputComponent = builder.input;
			addComponent(_inputComponent, "input");
			
			_physicsComponent = builder.physics;
			addComponent(_physicsComponent, "physics");
			
			_movementComponent = builder.mover;
			_movementComponent.addBinding("isTouching", "@input.isTouching");
			addComponent(_movementComponent, "movement");
			
			_renderComponent = builder.renderer;
			_renderComponent.addBinding("position", "@movement.position");
			addComponent(_renderComponent, "rendering");
			
			initialize();
		}
		
		public function collideWith(platformHitbox: Rectangle)
		{
			_movementComponent.handleCollision(hitbox, platformHitbox);
		}
		
		public function handleNoCollisions()
		{
			_movementComponent.handleNoCollisions();
		}
		
		public function die()
		{
			_movementComponent.stop();
		}
		
		public function get velocity(): Point   { return _movementComponent.velocity; }
		public function get position(): Point   { return _movementComponent.position; }
		public function get hitbox(): Rectangle { return _renderComponent.hitbox; }
	}
	
}