package  
{
	import org.flixel.*;
	/**
	 * ...
	 * @author SeiferTim Hely
	 */
	public class Boat extends FlxSprite 
	{
		
		//private var dirTmr:FlxTimer;
		
		public function Boat() 
		{
			super();
			makeGraphic(10, 4, 0xff335522);
			maxVelocity.x = 100;
			drag.x = 10;
			//dirTmr = new FlxTimer();
			//velocity.x = (10 + (FlxG.random() * 20));
			ChangeDir();
		}
		
		override public function update():void
		{
			super.update();
			if ( x < 10)
				x = 10;
			else if (x + width > FlxG.width - 10)
				x = FlxG.width - (10 + width);
			y = Globals.water.cols[int(x + (width / 2))].Height - height;
			ChangeDir();
			FlxG.log("x: " + velocity.x);
		}
		
		private function ChangeDir():void
		{
			
			var l:Number = 0;
			var r:Number = 0;
			var lC:int;
			var rC:int;
			var wC:WaterColumn;
			if (x > 10 && x < FlxG.width - 10)
			{
				for (var i:int = int(x); i < int(x + width);i++)
				{
					if (i < x + (width / 2))
					{
						lC++;
						l +=  Globals.water.cols[i].Height;
					}
					else if (i > x + (width / 2))
					{
						rC++;
						r +=  Globals.water.cols[i].Height;
					}
				}
				l /= lC;
				r /= rC;
				
				if (l > r)
					acceleration.x = -(l);
				else if (r > l)
					acceleration.x = (r);
				else
					velocity.x = 0;
				//else
				//	velocity.x = (-1 * (velocity.x / Math.abs(velocity.x))) * (10 + (FlxG.random() * 20));
			}
			//Timer.start(0.66  + (FlxG.random() * 2), 1, ChangeDir);
		}
		
	}

}