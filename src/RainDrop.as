package  
{
	import org.flixel.FlxSprite;
	/**
	 * ...
	 * @author SeiferTim Hely
	 */
	public class RainDrop extends FlxSprite
	{
		
		public function RainDrop() 
		{
			super();
			makeGraphic(1, 1, 0xff1166ff);
			acceleration.y = 100;
			maxVelocity.y = 300;
			kill();
			
		}
		
		
		
	}

}