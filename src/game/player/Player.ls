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