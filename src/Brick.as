package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	/**
	 * ...
	 * @author SeiferTim Hely
	 */
	public class Brick extends FlxSprite 
	{
		
		private var Gravity:Number = 0.98;
		
		public function Brick():void 
		{
			super();
			makeGraphic(10, 10, 0xffef1414);
			height = 8;
			width = 8;
			offset.x = 1;
			offset.y = 1;
			
			//reset(X, Y);
		}
		
		
		override public function reset(X:Number, Y:Number):void
		{
			super.reset(X, Y);
			velocity.y = y / 5;
			solid = true;
		}
		
		override public function update():void
		{
			if (y > FlxG.height) kill();
			else if (y + (height/2) > Globals.water.GetHeight(x))
			{
				velocity.y *= 0.94;
			}
			velocity.y += Gravity;
			
		}
		
		
	}

}