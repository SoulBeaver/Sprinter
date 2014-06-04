package sprinter.views  
{
	import loom2d.display.DisplayObjectContainer;
	import loom2d.display.Stage;
	import loom2d.animation.Transitions;
	import loom2d.Loom2D;
	import loom2d.ui.SimpleButton;
	import loom2d.ui.SimpleLabel;
	import sprinter.ui.ClickableLabel;
	
	import loom.lml.LML;
    import loom.lml.LMLDocument;

	public class MainMenuView extends View
	{
		[Bind]
		private var titleLabel: SimpleLabel;
		[Bind]
		private var playButton: ClickableLabel;
		
		public var onPlayGame: ViewCallback;
		
		public function MainMenuView()
		{
			super();
			
			var layout = LML.bind("assets/main_menu/main_menu.lml", this);
			layout.onLMLCreated += onLMLCreated;
			layout.apply();
		}
		
		private function onLMLCreated()
		{
			playButton.onClick += onPlayButtonClicked;
		}
		
		private function onPlayButtonClicked()
		{
			onPlayGame();
		}
		
		public function enter(stage: Stage)
		{
			super.enter(stage);
			
			fadeInUI();
		}
		
		private function fadeInUI()
		{
			var originalTitleX = titleLabel.x;
			var originalPlayX = playButton.x;
			
			titleLabel.x = 500;
			playButton.x = 500;
			
			Loom2D.juggler.tween(titleLabel, 1, { "x": originalTitleX, 
												  "delay": 0.2,
												  "transition": Transitions.EASE_OUT_BACK } );
			Loom2D.juggler.tween(playButton, 1, { "x": originalPlayX, 
												  "delay": 0.2,
												  "transition": Transitions.EASE_OUT_BACK } );
		}
		
		public function exit()
		{
			fadeOutUI();
		}
		
		private function fadeOutUI()
		{
			var offscreenX = -500;
			
			Loom2D.juggler.tween(titleLabel, 1, { "x": offscreenX, "transition": Transitions.EASE_IN_BACK } );
			Loom2D.juggler.tween(playButton, 1, { "x": offscreenX, 
												  "transition": Transitions.EASE_IN_BACK,
												  "onComplete": onFadeOutComplete } );
		}
		
		private function onFadeOutComplete()
		{
			super.exit();
		}
	}
	
}