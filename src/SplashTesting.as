package  
{
	
	import org.flixel.*;
	
	[SWF(width = "240", height = "400", backgroundColor = "#FFFFFF")]
	[Frame(factoryClass = "Preloader")]
	
	public class SplashTesting extends FlxGame
	{
		
		public function SplashTesting() 
		{
			super(240/2, 400/2, RunState, 2, 120, 120);
			
			FlxG.bgColor = 0xffffff;
			FlxG.debug = true;
			forceDebugger = true;
		}
		
	}

}