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

package sprinter
{
	import loom.utils.Injector;
	import loom2d.display.DisplayObjectContainer;
	import loom2d.display.Sprite;
	import loom2d.ui.TextureAtlasManager;
    import loom.Application;
    import loom2d.display.StageScaleMode;
    import loom2d.display.Image;
    import loom2d.textures.Texture;
    import loom2d.ui.SimpleLabel;
	import sprinter.views.MainMenuView;
	import sprinter.views.GameView;
	import sprinter.views.GameOverView;

	public class Sprinter extends Application
	{
		private var _mainMenuView: MainMenuView;
		private var _gameView: GameView;
		private var _gameOverView: GameOverView;
		
		override public function run(): void
		{
			TextureAtlasManager.register("sprinterSprites", "assets/pongSprites.xml");
			
			_mainMenuView = new MainMenuView();
			_mainMenuView.onPlayGame += onPlayGame;
			
			_gameView = new GameView();
			_gameView.group = group;
			
			_gameOverView = new GameOverView();
			_gameOverView.onRetryGame += onRetryGame;
			
			_mainMenuView.enter(stage);
		}
		
		private function onPlayGame()
		{
			_mainMenuView.exit();
			_mainMenuView.onExit += onMenuExit;
		}
		
		private function onMenuExit()
		{
			_gameView.enter(stage);
			_gameView.level.onFinished += onGameOver;
			
			_mainMenuView.onExit -= onMenuExit;
		}
		
		private function onGameOver(score: Number)
		{
			_gameView.level.onFinished -= onGameOver;
			_gameView.exit();
			
			_gameOverView.setScore(score);
			_gameOverView.enter(stage);
		}
		
		private function onRetryGame()
		{
			_gameOverView.exit();
			
			_gameView.enter(stage);
			_gameView.level.onFinished += onGameOver;
		}
	}
}