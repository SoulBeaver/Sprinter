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

package sprinter.views 
{
	import loom.gameframework.LoomGroup;
	import sprinter.game.SprintLevel;
	import loom2d.Loom2D;
	import loom2d.display.DisplayObjectContainer;
	import loom2d.display.Stage;
	
	public class GameView extends View
	{
		public var level: SprintLevel;
		public var group: LoomGroup;
		
		public function enter(stage: Stage)
		{
			super.enter(stage);
			
			Debug.assert(!level, "The level was alread initialized.");

			level = new SprintLevel();
			level.owningGroup = group;
			level.create(stage);
		}
		
		public function exit()
		{
			Debug.assert(level, "The level was never initialized.");
			
			level.destroy();
			level = null;
			
			super.exit();
		}
	}
	
}