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