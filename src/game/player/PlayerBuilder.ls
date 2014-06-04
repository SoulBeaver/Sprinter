package sprinter.game.player 
{
	import sprinter.game.*;
	
	public class PlayerBuilder
	{
		private var _movementComponent: PlayerMovementComponent;
		private var _renderComponent: RenderComponent;
		private var _physicsComponent: PhysicsComponent;
		private var _inputComponent: InputComponent;
		
		public static function create(): PlayerBuilder
		{
			return new PlayerBuilder();
		}
		
		public function withMover(mover: PlayerMovementComponent): PlayerBuilder
		{
			_movementComponent = mover;
			return this;
		}
		
		public function withRenderer(renderer: RenderComponent): PlayerBuilder
		{
			_renderComponent = renderer;
			return this;
		}
		
		public function withPhysics(physics: PhysicsComponent): PlayerBuilder
		{
			_physicsComponent = physics;
			return this;
		}
		
		public function withInput(input: InputComponent): PlayerBuilder
		{
			_inputComponent = input;
			return this;
		}
		
		public function build(): Player
		{
			validate();
			
			return new Player(this);
		}
		
		private function validate()
		{
			Debug.assert(_movementComponent, "No MovementComponent specified");
			Debug.assert(_renderComponent, "No RenderComponent specified");
			Debug.assert(_physicsComponent, "No PhysicsComponent specified");
			Debug.assert(_inputComponent, "No InputComponent specified");
		}
		
		public function get mover(): PlayerMovementComponent
		{
			return _movementComponent;
		}
		
		public function get renderer(): RenderComponent
		{
			return _renderComponent;
		}
		
		public function get physics(): PhysicsComponent
		{
			return _physicsComponent;
		}
		
		public function get input(): InputComponent
		{
			return _inputComponent;
		}
	}
	
}