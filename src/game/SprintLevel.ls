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
	import loom.gameframework.IAnimated;
	import loom.gameframework.LoomGameObject;
	import loom.gameframework.LoomGroup;
	import loom.gameframework.TimeManager;
	import loom2d.display.Image;
	import loom2d.display.Sprite;
	import loom2d.display.Stage;
	import loom2d.math.Point;
	import loom2d.math.Rectangle;
	import loom2d.textures.Texture;
	import loom2d.ui.SimpleLabel;
	import sprinter.game.platform.PlatformManager;
	import sprinter.game.player.Player;
	import sprinter.game.player.PlayerFactory;
	import sprinter.util.Rect;
	
	public delegate GameFinishedEvent(score: Number): void;
	
	public class SprintLevel extends LoomGroup
							 implements IAnimated
	{
		[Inject]
		public var timeManager: TimeManager;
	
		public var onFinished: GameFinishedEvent;
		
		private var _stage: Stage;
		private var _gameLayer: Sprite;
		private var _uiLayer: Sprite;
		
		private var _background: Image;
		
		private var _player: Player;
		private var _platformManager: PlatformManager;
		
		private var _scoreLabel: SimpleLabel;
		private var _score: Number;
		
		public function create(stage: Stage, name: String = "SprintLevel")
		{
			super.initialize(name);
			
			Debug.assert(timeManager, "The TimeManager was not initialized.");
			
			_stage = stage;
			
			_background = new Image(Texture.fromAsset("assets/background.png"));
			_stage.addChild(_background);
			
			_gameLayer = new Sprite();
			_gameLayer.touchable = true;
			_uiLayer = new Sprite();
			
			stage.addChild(_gameLayer);
			stage.addChild(_uiLayer);
			
			var playerSpawnPosition = new Point(230, -50);
			_player = PlayerFactory.create(_gameLayer, playerSpawnPosition);
			
			_platformManager = new PlatformManager(_gameLayer);
			_platformManager.spawnPlatformsRelativeTo(new Point(playerSpawnPosition.x, 150));
			
			_score = 0;
			
			_scoreLabel = new SimpleLabel("assets/Curse-hd.fnt");
			_scoreLabel.scale = 0.3;
			_scoreLabel.x = stage.nativeStageWidth - 100;
			_scoreLabel.y = 5;
			_scoreLabel.text = "Score: " +_score;
			stage.addChild(_scoreLabel);
			
			timeManager.addAnimatedObject(this);
			timeManager.addAnimatedObject(_platformManager);
		}
		
		public function onFrame()
		{
			if (playerDied())
			{
				_player.die();
				onFinished(_score);
				
				return;
			}
			
			_platformManager.setGapWidthRelativeTo(_player.velocity);
			
			if (!detectCollisions()) _player.handleNoCollisions();
				
			centerOnPlayer();
			
			updateScore();
		}
		
		private function playerDied(): Boolean
		{
			return _player.hitbox.y > _stage.nativeStageHeight;
		}
		
		private function detectCollisions(): Boolean
		{			
			for each (var platform in _platformManager.platforms)
			{
				var platformHitbox = (platform.lookupComponentByName("rendering") as RenderComponent).hitbox;
				
				if (Rect.intersects(_player.hitbox, platformHitbox))
				{
					_player.collideWith(platformHitbox);
					return true;
				}
			}
			
			return false;
		}
		
		private function centerOnPlayer()
		{
			_gameLayer.x -= _player.velocity.x;
		}
		
		private function updateScore()
		{
			_score = Math.round(_score + _player.velocity.x);
			_scoreLabel.text = "Score: " +_score;
		}
		
		public function destroy()
		{
			_player.destroy();
			_platformManager.destroy();
			_score = 0;
			
			timeManager.removeAnimatedObject(_platformManager);
			timeManager.removeAnimatedObject(this);
			
			super.destroy();
			
			_stage.removeChild(_background);
			_stage.removeChild(_scoreLabel);
			_stage.removeChild(_gameLayer);
			_stage.removeChild(_uiLayer);
			_stage = null;
		}
	}	
}