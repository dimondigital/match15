/**
 * Created by ElionSea on 24.01.15.
 */
package
{
import flash.events.TimerEvent;
import flash.utils.Timer;

/* CLOCKS
* часы
* */
public class Clocks
{
    private var _view:McClocks;
    private var secCount:uint = 0;
    private var minCount:uint = 0;

    private var _timer:Timer;
    private var _gameModel:GameModel;

    /*CONSTRUCTOR*/
    public function Clocks(gameModel:GameModel, view:McClocks)
    {
        _gameModel = gameModel;
        _view = view;
    }

    /* START */
    public function start():void
    {
        _timer = new Timer(1000);
        _timer.addEventListener(TimerEvent.TIMER, oneSecondTick);
        _timer.start();
    }

    /* ONE SECOND TICK */
    private function oneSecondTick(e:TimerEvent):void
    {
        secCount += 1;
        if (secCount == 60)
        {
            minCount += 1;
            secCount = 0;
        }
        updateClocks();
    }

    /* UPDATE CLOCKS */
    private function updateClocks():void
    {
        if (secCount < 10)  _view.timeSeconds_txt.text = "0" + secCount.toString();
        else                _view.timeSeconds_txt.text = secCount.toString();

        if (minCount < 10)  _view.timeMinutes_txt.text = "0" + minCount.toString();
        else                _view.timeMinutes_txt.text = minCount.toString();

        _gameModel.totalMinutes = minCount;
        _gameModel.totalSeconds = secCount;
    }

    /* RESTART */
    public function restart():void
    {
        secCount = 0;
        minCount = 0;

        updateClocks();
        _timer.reset();
        _timer.start();
    }

    /* STOP */
    public function stop():void
    {
        _timer.stop();
    }
}
}
