/**
 * Created by ElionSea on 24.01.15.
 */
package
{
import flash.display.Stage;
import flash.events.MouseEvent;

/* GAME CONTROLLER
*
* */
public class GameController
{
    private var _stage:Stage;
    private var _gameModel:GameModel;
    private var _chipsTable:ChipsTable;
    private var _gameInterface:GameInterface;
    private var _winBoard:WinBoard;

    /*CONSTRUCTOR*/
    public function GameController(stage:Stage)
    {
        _stage = stage;
    }

    /* INIT */
    public function init():void
    {
        _gameModel = new GameModel();

        _chipsTable = new ChipsTable(_stage, 4);
        _chipsTable.init();
        _gameInterface = new GameInterface(_stage, _gameModel);
        _gameInterface.init();
        _winBoard = new WinBoard(_stage, _gameInterface.clocks);

        _stage.addEventListener(MouseEvent.CLICK, clickListener);
        _stage.addEventListener(CustomEvent.WIN, win, true);
    }

    /* WIN */
    private function win(e:CustomEvent=null):void
    {
        _winBoard.win(_gameModel);
    }

    /* CLICK LISTENER */
    private function clickListener(e:MouseEvent):void
    {
        if(e.target is McChip)
        {
            _chipsTable.move(McChip(e.target));
        }
    }
}
}
