package sprinter.util 
{
	import loom2d.math.Rectangle;
	
	public class Rect
	{
		public static function intersects(r1: Rectangle, r2: Rectangle): Boolean 
		{
			return !(r2.left > r1.right || 
			  	     r2.right < r1.left || 
				     r2.top > r1.bottom ||
				     r2.bottom < r1.top);
		}
	}	
}