package  
{
	/**
	 * ...
	 * @author SeiferTim Hely
	 */
	public class WaterColumn 
	{
		
		public var TargetHeight:Number;
		public var Height:Number;
		public var Speed:Number;
		
		public function Update(dampening:Number, tension:Number):void
		{
			var x:Number = TargetHeight - Height;
			Speed += tension * x - Speed * dampening;
			Height += Speed;
		}
		
	}

}