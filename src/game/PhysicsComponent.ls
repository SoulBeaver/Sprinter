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