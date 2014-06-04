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