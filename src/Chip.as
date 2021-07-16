package   
{

/* CHIP
 * фишка
  * */
	public class Chip
	{
        private var _view:McChip;
		public static var chipArray:Array;
		public static const CHIP_SIZE:uint = 82;	// ширина фишки
		public static const EMPTY:uint = 16;	    // пустышка
		private var _state:Boolean;					// на своём ли месте
		private var _trueCol:uint;					// истинный столбик пятнашки
        private var _curCol:uint;					// текущий столбик пятнашки
        private var _curRow:uint;					// текущий ряд пятнашки
        private var _trueRow:uint;					// истинный ряд пятнашки
        private var _id:int;					    // номер пятнашки
		
		// CONSTRUCTOR
		public function Chip(id:uint):void
		{
            _view = new McChip();
            _id = id;
            _view.name = id.toString();
            _view.gotoAndStop(_id);

            if (id == Chip.EMPTY)
            {
                _view.visible = false;
            }
		}

        /* CHECKING STATE */
        // проверка правильного положения фишки
		public function checkingState():Boolean
		{
			state = (_curRow == _trueRow && _curCol == _trueCol);
			return state;
		}

		public function set curCol(newCol:uint):void{_curCol = newCol;}
		public function get curCol():uint{return _curCol;}

		public function set curRow(newRow:uint):void{_curRow = newRow;}
		public function get curRow():uint{return _curRow;}

		public function set trueCol(newTrueCol:uint):void{_trueCol = newTrueCol;}
		public function set trueRow(newTrueRow:uint):void{_trueRow = newTrueRow;}

		public function set id(value:int):void{_id = value;}
		public function get id():int{return _id;}

		public function get state():Boolean{return _state;}
		public function set state(value:Boolean):void{_state = value;}

        public function get view():McChip {return _view;}
}
}
