package sprinter.util 
{
	
	public class Coin 
	{
		public static function flip(): Boolean
		{
			return Math.round(Math.random()) < 0.5;
		}
	}
	
}