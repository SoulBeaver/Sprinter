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