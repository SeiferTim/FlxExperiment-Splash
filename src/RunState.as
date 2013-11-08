package  
{
	import org.flixel.*;
	
	/**
	 * ...
	 * @author SeiferTim Hely
	 */
	public class RunState extends FlxState 
	{
		private var water:Water;
		
		override public function create():void
		{
			water = new Water();
			add(water)
			Globals.water = water;
			
		}
		
	}

}