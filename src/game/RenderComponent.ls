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
	import loom.gameframework.AnimatedComponent;
	import loom2d.display.DisplayObjectContainer;
	import loom2d.math.Point;
	import loom2d.math.Rectangle;
	import loom2d.ui.TextureAtlasSprite;
	
	public class RenderComponent extends AnimatedComponent
	{
		private var _parent: DisplayObjectContainer;
		private var _spawnCoordinates: Point;
		private var _textureName: String;
		private var _texture: TextureAtlasSprite;
		
		public function RenderComponent(parent: DisplayObjectContainer,
										spawnCoordinates: Point,
										textureName: String)
		{
			_parent = parent;
			_spawnCoordinates = spawnCoordinates;
			_textureName = textureName;
		}
		
		protected function onAdd(): Boolean
		{
			if (!super.onAdd())
				return false;
			
			_texture = new TextureAtlasSprite();
			_texture.atlasName = "sprinterSprites";
			_texture.textureName = _textureName;
			_texture.center();
			_texture.x = _spawnCoordinates.x;
			_texture.y = _spawnCoordinates.y;
			
			_parent.addChild(_texture);
			return true;
		}
		
		protected function onRemove()
		{
			_parent = null;
			
			super.onRemove();
		}
		
		public function set position(value: Point)
		{
			_texture.x = value.x;
			_texture.y = value.y;
		}
		
		public function set scaleX(value: Number)
		{
			_texture.scaleX = value;
		}
		
		public function get hitbox(): Rectangle { return _texture ? _texture.bounds : new Rectangle(0, 0, 0, 0); }
	}
	
}