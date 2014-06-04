package sprinter.game.player 
{
	import loom.gameframework.TickedComponent;
	import loom2d.math.Point;
	import loom2d.math.Rectangle;
	import sprinter.game.PhysicsComponent;
	import sprinter.util.Rect;
	
	public enum MovementState
	{
		SPRINTING,
		JUMPING,
		FALLING,
		FREE_FALLING,
		STOPPED
	}
	
	public class PlayerMovementComponent extends TickedComponent
	{
		private static const ACCELERATION = 0.05;
		private static const MAXIMUM_VELOCITY = 5;
		
		private static const JUMP_FORCE = 0.5;
		private static const MAXIMUM_JUMP_VELOCITY = 3;
		
		private var _state = MovementState.JUMPING;
		
		private var _physicsComponent: PhysicsComponent;
		private var _desiredPosition: Point;
		public var velocity: Point;
		public var jumpVelocity: Point;
		
		public var isTouching: Boolean = false;
		public var position: Point;
		
		public function PlayerMovementComponent(physicsComponent: PhysicsComponent)
		{
			_physicsComponent = physicsComponent;
		}
		
		public function onTick()
		{
			super.onTick();
			
			_desiredPosition = _physicsComponent.position;
			velocity = _physicsComponent.velocity;
			
			switch (_state)
			{
				case MovementState.SPRINTING:
					if (isTouching)
					{
						velocity.y = -JUMP_FORCE;
						_state = MovementState.JUMPING;
					}
						
					if (velocity.x < MAXIMUM_VELOCITY)
						velocity.x += ACCELERATION;
						
					position.x = _desiredPosition.x + velocity.x;
					break;
					
				case MovementState.JUMPING:
					if (isTouching)
						jump();
						
					position.x = _desiredPosition.x + velocity.x;
					position.y = _desiredPosition.y + velocity.y;
					break;
					
				case MovementState.FALLING:
					position.x = _desiredPosition.x + velocity.x;
					position.y = _desiredPosition.y;
					break;
					
				case MovementState.FREE_FALLING:
					position.y = _desiredPosition.y;
					break;
					
				case MovementState.STOPPED:
					velocity = new Point(0, 0);
					break;
			}
			
			_physicsComponent.position = position;
			_physicsComponent.velocity = velocity;
		}
		
		private function jump()
		{
			if ( -velocity.y < MAXIMUM_JUMP_VELOCITY) 
				velocity.y -= JUMP_FORCE;
			else 
				_state = MovementState.FALLING;
				
			Debug.print("State:  " +_state);
		}
		
		public function handleCollision(playerHitbox: Rectangle, platformHitbox: Rectangle)
		{
			if (_state == MovementState.FREE_FALLING || _state == MovementState.STOPPED)
				return;
				
			if (_state == MovementState.JUMPING && velocity.y < 0)
				return;
				
			if (hitPlatformSide(playerHitbox, platformHitbox))
			{
				_physicsComponent.velocity.x = 0;
				position.y += velocity.y;
				
				_state = MovementState.FREE_FALLING;
			} 
			else
			{
				_physicsComponent.velocity.y = 0;
				position.y = (platformHitbox.y - playerHitbox.height / 2);
				_state = MovementState.SPRINTING;
			}			
		}
		
		private function hitPlatformSide(playerHitbox: Rectangle, platformHitbox: Rectangle): Boolean
		{
			return (playerHitbox.bottom > platformHitbox.top &&
					(playerHitbox.right > platformHitbox.left && playerHitbox.right < platformHitbox.left + 5));
		}
		
		public function handleNoCollisions()
		{
			if (_state == MovementState.SPRINTING)
				_state = MovementState.FALLING;
		}
		
		public function stop()
		{
			_state = MovementState.STOPPED;
			velocity = new Point(0, 0);
		}
	}
	
}