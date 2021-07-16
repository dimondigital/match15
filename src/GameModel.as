/**
 * Created by ElionSea on 24.01.15.
 */
package
{
public class GameModel
{
    private var _totalMoves:int;
    private var _totalMinutes:int;
    private var _totalSeconds:int;

    /*CONSTRUCTOR*/
    public function GameModel()
    {

    }

    public function get totalMoves():int {return _totalMoves;}
    public function set totalMoves(value:int):void {_totalMoves = value;}

    public function get totalMinutes():int {return _totalMinutes;}
    public function set totalMinutes(value:int):void {_totalMinutes = value;}

    public function get totalSeconds():int {return _totalSeconds;}
    public function set totalSeconds(value:int):void {_totalSeconds = value;}
}
}
