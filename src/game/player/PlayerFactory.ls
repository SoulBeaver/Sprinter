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