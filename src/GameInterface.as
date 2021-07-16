package 
{
import flash.display.Stage;
import flash.events.Event;
import flash.events.MouseEvent;

/* GAME INTERFACE
 * боковая панель-интерфейс
 */
	public class GameInterface
	{
        private var _view:McChipInterface;
		private var _clocks:Clocks;
        private var _stage:Stage;
        private var _gameModel:GameModel;

        /* CONSTRUCTOR */
		public function GameInterface(stage:Stage, gameModel:GameModel):void
		{
            _stage = stage;
            _gameModel = gameModel;
        }

        /* INIT */
		internal function init():void
		{
            _view = new McChipInterface();
            _view.x = _stage.width;
            _stage.addChild(_view);

            _clocks = new Clocks(_gameModel, _view.clocks_mc);
            _clocks.start();

            _view.restart_btn.addEventListener(MouseEvent.CLICK, dispatchRestart);
            _stage.addEventListener(CustomEvent.MOVE, plusMove, true);
            _stage.addEventListener(CustomEvent.RESTART, restart);
		}

        /* DISPATCH RESTART */
        private function dispatchRestart(e:MouseEvent):void
        {
            _view.dispatchEvent(new CustomEvent(CustomEvent.RESTART));
            restart(null);
        }
		
        /* BUTTON RESTART */
		private function restart(e:CustomEvent=null):void
		{
            _clocks.restart();
            _gameModel.totalMoves = 0;
            updateMoveCounter();
		}
		
        /* PLUS MOVE */
		public function plusMove(e:CustomEvent):void
		{
            _gameModel.totalMoves++;
			// обновляем счётчик
			updateMoveCounter();
		}
		
        /* UPDATE MOVE COUNTER */
		private function updateMoveCounter():void
		{
			// обновление счётчика ходов
			_view.moveCounter_mc.moves_txt.text = _gameModel.totalMoves.toString();
		}

        public function get clocks():Clocks {
            return _clocks;
        }
    }
}






