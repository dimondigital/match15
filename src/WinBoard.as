/**
 * Created by ElionSea on 24.01.15.
 */
package
{
import flash.display.Stage;
import flash.events.MouseEvent;

/* WIN BOARD
 * доска выигрыша
 */
public class WinBoard
{
    private var winMask:McWinMask;
    private var _gameModel:GameModel;
    private var _view:McWinBoard;
    private var _stage:Stage;
    private var _clocks:Clocks;

    /*CONSTRUCTOR*/
    public function WinBoard(stage:Stage, clocks:Clocks)
    {
        _stage = stage;
        _clocks = clocks;
    }

    /* WIN */
    public function win(gameModel:GameModel):void
    {
        _clocks.stop();
        _gameModel = gameModel;

        winMask = new McWinMask();
        winMask.alpha = 0.3;
        _stage.addChild(winMask);


        _view = new McWinBoard();
        _stage.addChild(_view);
        _view.x = 50;
        _view.y = 50;

        _view.resultMoves_txt.text = gameModel.totalMoves.toString();
        _view.resultTime_txt.text = gameModel.totalMinutes + " min " + gameModel.totalSeconds + " sec";

        _view.winRestart_btn.addEventListener(MouseEvent.CLICK, restart);
    }

    /* RESTART */
    private function restart(e:MouseEvent):void
    {
        _clocks.restart();

        _gameModel.totalMoves = 0;

        _stage.removeChild(winMask);
        _stage.removeChild(_view);

        _view.winRestart_btn.removeEventListener(MouseEvent.CLICK, restart);

        _stage.dispatchEvent(new CustomEvent(CustomEvent.RESTART));
    }
}
}
