package sprinter.game 
{
	import loom.gameframework.TickedComponent;
	import loom2d.math.Point;
	
	public class PhysicsComponent extends TickedComponent
	{
		private static const GRAVITY = 0.2;
		private static const MAXIMUM_GRAVITY = 5;
		
		public var velocity: Point;
		public var position: Point;
		
		public function PhysicsComponent(initialVelocity: Point,
										 initialPosition: Point)
		{
			velocity = initialVelocity;
			position = initialPosition;
		}
		
		public function onTick()
		{
			super.onTick();
			
			if (velocity.y < MAXIMUM_GRAVITY)
				velocity.y += GRAVITY;
			position.y += velocity.y;
		}
	}
}