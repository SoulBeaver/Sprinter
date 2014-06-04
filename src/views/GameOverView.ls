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
	import loom2d.Loom2D;
	import loom2d.display.DisplayObjectContainer;
	import loom2d.display.Stage;
	import loom2d.ui.SimpleLabel;
	import loom.lml.LML;
    import loom.lml.LMLDocument;
	import sprinter.ui.ClickableLabel;
	import sprinter.views.View;
	
	public class GameOverView extends View
	{
		[Bind]
		private var scoreLabel: SimpleLabel;
		[Bind]
		private var retryButton: ClickableLabel;
		
		public var onRetryGame: ViewCallback;
		
		public function GameOverView() 
		{
			super();
			
			var layout = LML.bind("assets/game_over/game_over.lml", this);
			layout.onLMLCreated += onLMLCreated;
			layout.apply();
		}
		
		private function onLMLCreated()
		{			
			retryButton.onClick += onRetryButtonClicked;
		}
		
		private function onRetryButtonClicked()
		{
			onRetryGame();
		}
		
		public function setScore(value: Number) 
		{
			scoreLabel.text = String.format("You scored %d points!", value);
			scoreLabel.center();
			scoreLabel.x = Loom2D.stage.nativeStageWidth / 2;
		}
	}
	
}