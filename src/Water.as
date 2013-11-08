package  
{
	import org.flixel.*;
	import flash.display.BlendMode;
	import org.flixel.plugin.photonstorm.FlxGradient;
	
	/**
	 * ...
	 * @author SeiferTim Hely
	 */
	public class Water extends FlxGroup
	{
		private var Columns:Vector.<WaterColumn>;
		
		private var Waves:FlxGroup;
		private var Rain:FlxGroup;
		
		public const Tension:Number = 0.03;
		public const Dampening:Number = 0.02;
		public const Spread:Number = 0.1;
		
		private var grpBricks:FlxGroup;
		
		private var boat:Boat;
		//private var Bricks:Vector.<Brick>;
		
		[Embed(source = "water.png")]private var ImgWater:Class;
		
		public function Water() 
		{
				
			Columns = new Vector.<WaterColumn>();
			
			grpBricks = new FlxGroup(10);
			add(grpBricks);
			
			boat = new Boat();
			
			add(boat);
			
			
			Waves = new FlxGroup();
			add(Waves);
			
			
			
			Rain = new FlxGroup(180);
			add(Rain);
			
			
			for (var i:int = 0; i < FlxG.width; i++)
			{
				Columns.push(new WaterColumn);
				Waves.add(new FlxSprite(i,FlxG.height/2).loadGraphic(ImgWater));					//new FlxSprite(i, FlxG.height / 2).makeGraphic(1, FlxG.height, 0xff1166ff));
				Columns[i].Height = FlxG.height / 2;
				Columns[i].TargetHeight = FlxG.height / 2;
				Columns[i].Speed = 0;
			}
			
			boat.x = 10 + (FlxG.random() * (FlxG.width - 20));
			boat.y = Columns[int(boat.x + (boat.width / 2))].Height;
			
			FlxG.mouse.show();
			
			
		}
		
		public function GetHeight(X:Number):Number
		{
			if (X < 0 || X > FlxG.width)
				return 240;
			return Columns[int(X)].Height;
		}
		
		public function get cols():Vector.<WaterColumn>
		{
			return Columns;
		}
		
		public function Clamp(Value:Number, Min:Number, Max:Number):Number
		{
			if (Value > Max) return Max;
			if (Value < Min) return Min;
			return Value;
		}
		
		public function Splash(xPos:Number, Speed:Number):void
		{
			var index:int = Clamp(xPos, 0, Columns.length - 1);
			for (var i:int = Math.max(0, index - 0); i < Math.min(Columns.length - 1, index + 1); i++)
			{
				Columns[index].Speed = Speed;
			}
		}
		
		override public function update():void
		{
			super.update();
			
			for (var i:int = 0; i < Columns.length; i++)
			{
				Columns[i].Update(Dampening, Tension);
			}
			
			var lDeltas:Array = new Array(Columns.length);
			var rDeltas:Array = new Array(Columns.length);
			
			for (var j:int = 0; j < 8; j++)
			{
				for (var k:int = 0; k < Columns.length; k++)
				{
					if (k > 0)
					{
						lDeltas[k] = Spread * (Columns[k].Height - Columns[k - 1].Height);
						Columns[k - 1].Speed += lDeltas[k];
					}
					if (k < Columns.length - 1)
					{
						rDeltas[k] = Spread * (Columns[k].Height - Columns[k + 1].Height);
						Columns[k + 1].Speed += rDeltas[k];
					}
				}
				
				for (var l:int = 0; l < Columns.length; l++)
				{
					if (l > 0)
					{
						Columns[l - 1].Height += lDeltas[l];
					}
					if (l < Columns.length - 1)
					{
						Columns[l + 1].Height += rDeltas[l];
					}
					Waves.members[l].y = Columns[l].Height;
				}				
				
			}
			var c:int = FlxG.random() * 2;
			for (var m:int = 0; m < c; m++)
			{
				var rD:RainDrop = Rain.recycle(RainDrop) as RainDrop;//Rain.getFirstAvailable(RainDrop) as RainDrop;
				//if (!rD)
				//{
				//	rD = Rain.add(new RainDrop()) as RainDrop;
				//}
				rD.reset(FlxG.random() * FlxG.width, -4 - (FlxG.random() * +4));
				
			}
			
			FlxG.overlap(Rain, Waves, RainHit);
			
			
			if (FlxG.mouse.justReleased())
			{
				if (FlxG.mouse.y < (FlxG.height / 2) - 20)
				{
					if (grpBricks.countLiving() < 10)
					{
						var bk:Brick = grpBricks.recycle(Brick) as Brick;
						bk.reset(FlxG.mouse.x - 5, FlxG.mouse.y - 5)
					}
				}
			}
			
			FlxG.overlap(grpBricks, Waves, BrickHit);
			
		}
		
		private function BrickHit(B:FlxSprite, W:FlxSprite):void
		{
			
			if (B.alive && B.exists && B.y + B.height > W.y + 4 && B.solid)
			{
				Splash(W.x, B.velocity.y * .4)
				B.solid = false;
			}
			
		}
		
		private function RainHit(R:RainDrop, W:FlxSprite):void
		{
			if(R.alive && R.exists)
			{
				R.kill();
				Splash(R.x, (FlxG.random() * 3) * (300/R.velocity.y));
			}
			
		}
		
		
	}

}