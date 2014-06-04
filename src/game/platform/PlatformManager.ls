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

package sprinter.game.platform 
{
	import loom.gameframework.IAnimated;
	import loom.gameframework.LoomGameObject;
	import loom2d.display.DisplayObjectContainer;
	import loom2d.math.Point;
	import loom2d.math.Rectangle;
	import sprinter.game.RenderComponent;
	import sprinter.game.platform.PlatformFactory;
	
	public class PlatformManager implements IAnimated
	{
		private static const SPAWNABLE_PLATFORMS = 5;
		private static const PLATFORM_BASE_WIDTH = 128;
		private static const PLATFORM_BASE_HEIGHT = 32;
		
		private var _parent: DisplayObjectContainer;
		private var _relativeSpawnPosition: Point;
		
		private var _platforms = new Vector.<LoomGameObject>();
		private var _gapWidth: Number = 100;
		
		public function PlatformManager(parent: DisplayObjectContainer)
		{
			_parent = parent;
		}
		
		public function onFrame()
		{
			respawnOutOfBoundsPlatforms();
		}
		
		public function spawnPlatformsRelativeTo(position: Point)
		{
			_relativeSpawnPosition = position;
			
			for (var i = 0; i < SPAWNABLE_PLATFORMS; i++)
				_platforms.push(spawnPlatform());
		}
		
		private function respawnOutOfBoundsPlatforms()
		{
			var platformsToDelete = new Vector.<LoomGameObject>();
			
			for each (var platform in _platforms)
			{
				var hitbox = (platform.lookupComponentByName("rendering") as RenderComponent).hitbox;
				
				if (platformIsOutOfBounds(hitbox))
				{
					platformsToDelete.push(platform);
				
					_platforms.push(spawnPlatform());
				}
			}
			
			for each (var platformToDelete in platformsToDelete)
				_platforms.remove(platformToDelete);
		}
		
		private function platformIsOutOfBounds(hitbox: Rectangle): Boolean
		{
			return (_parent.x + hitbox.right < 0);
		}
		
		private function spawnPlatform(): LoomGameObject
		{
			var newestPlatformHitbox =  _platforms.length > 0 ? (last(_platforms).lookupComponentByName("rendering") as RenderComponent).hitbox
															  : new Rectangle(0, _relativeSpawnPosition.y, PLATFORM_BASE_WIDTH, PLATFORM_BASE_HEIGHT);
			
			var spawnPosition = new Point(newestPlatformHitbox.x + newestPlatformHitbox.width + _gapWidth,
										  _relativeSpawnPosition.y + newestPlatformHitbox.height + randomHeightGap(-40, 40));
			var scale = 1.0 + (Math.random() * 0.5);
			
			var newPlatform = PlatformFactory.create(_parent, spawnPosition);
			newPlatform.setProperty("@rendering.scaleX", scale);
			
			return newPlatform;
		}
		
		private function last(vector: Vector.<LoomGameObject>): LoomGameObject
		{
			return vector.length > 0 ? vector[vector.length - 1] : null;
		}
		
		private function randomHeightGap(minimum: Number, maximum: Number): Number
		{
			return minimum + Math.random() * (maximum - minimum + 1);
		}
		
		public function setGapWidthRelativeTo(velocity: Point)
		{
			_gapWidth = PLATFORM_BASE_WIDTH + (10 * velocity.x);
		}
		
		public function destroy()
		{
			while (_platforms.length > 0)
			{
				var platform = _platforms.pop();
				platform.destroy();
			}
			
			_platforms = null;
		}
		
		public function get platforms(): Vector.<LoomGameObject> { return _platforms; }
	}	
}