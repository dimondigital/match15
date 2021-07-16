/**
 * Created by ElionSea on 24.01.15.
 */
package
{
import com.greensock.TweenLite;
import flash.display.Stage;

/* CHIPS TABLE
* массив с пятнашками
*/
public class ChipsTable
{
    private var _view:McMainSprite;
    private var _stage:Stage;
    private var _chips:Array;
    private var _fieldSize:int;
    private var _isTableCanClicked:Boolean = true;

    /*CONSTRUCTOR*/
    public function ChipsTable(stage:Stage, fieldSize:int)
    {
        _stage = stage;
        _fieldSize = fieldSize;
    }

    /* INIT */
    public function init():void
    {
        _view = new McMainSprite();
        _stage.addChild(_view);
        _view.x += 32;
        _view.y += 32;

        placeChips();
        mixChips();

        _stage.addEventListener(CustomEvent.RESTART, restart, true);
    }

    /* PLACE CHIPS */
    private function placeChips():void
    {
        _chips = [];
        var Id:uint;

        for (var row:uint = 0; row < _fieldSize; row++)
        {
            _chips[row] = [];
            for (var col:uint = 0; col < _fieldSize; col++)
            {
                Id = (row * _fieldSize) + 1 + col; // номер фишки
                var chip:Chip = new Chip(Id);
                _chips[row][col] = chip;

                chip.view.x = Chip.CHIP_SIZE * col;
                chip.view.y = Chip.CHIP_SIZE * row;
                chip.curCol = col;
                chip.curRow = row;
                // запоминаем верные позиции фишек
                chip.trueCol = col;
                chip.trueRow = row;

				_view.addChild(chip.view);
            }
        }
    }

    /* RESTART */
    private function restart(e:CustomEvent):void
    {
        mixChips();
    }

    /* MIX CHIPS */
    // перемешивание всех фишек
    public function mixChips():void
    {
        for (var row:uint = 0; row < _fieldSize; row++)
        {
            for (var col:uint = 0; col < _fieldSize; col++)
            {
                var rand1:uint = Math.floor(Math.random()*(_fieldSize-1));
                var rand2:uint = Math.floor(Math.random()*(_fieldSize-1));

                var currentChip:Chip = _chips[row][col];
                var randomChip:Chip = _chips[rand1][rand2];
                mixTwoChips(currentChip, randomChip);
            }
        }
    }

    /* MIX TWO CHIPS */
    // перемешивание двух фишек
    private function mixTwoChips(currentChip:Chip, randomChip:Chip, byCoordinates:Boolean=true):void
    {
        var tmpX:uint;
        var tmpY:uint;
        var tmpCol:uint;
        var tmpRow:uint;

        if(byCoordinates)
        {
            // по X
            tmpX = currentChip.view.x;
            currentChip.view.x = randomChip.view.x;
            randomChip.view.x = tmpX;
            // по Y
            tmpY = currentChip.view.y;
            currentChip.view.y = randomChip.view.y;
            randomChip.view.y = tmpY;
        }

        // col
        tmpCol = currentChip.curCol;
        currentChip.curCol = randomChip.curCol;
        randomChip.curCol = tmpCol;
        // row
        tmpRow = currentChip.curRow;
        currentChip.curRow = randomChip.curRow;
        randomChip.curRow = tmpRow;
    }

    /* MOVE */
    public function move(clickedChipView:McChip):void
    {
        var canSwap:Boolean = false;
        var emptyChip:Chip = getChipById(Chip.EMPTY);
        var clickedChipId:int = int(clickedChipView.name);
        var clickedChip:Chip = getChipById(clickedChipId);

        // если поле кликабельно и кликнутая фишка не является "пустышкой"
        if (_isTableCanClicked)
        {
            // Eсли кликнутая фишка <ВЫШЕ> "пустышки"
            if (emptyChip.curCol == clickedChip.curCol
                    && clickedChip.curRow == emptyChip.curRow - 1)
            {
                _isTableCanClicked = false;
                canSwap = true;
            }
            // Eсли кликнутая фишка <НИЖЕ> "пустышки"
            else if (emptyChip.curCol == clickedChip.curCol
                    && clickedChip.curRow == emptyChip.curRow + 1)
            {

                _isTableCanClicked = false;
                canSwap = true;
            }
            // Eсли кликнутая фишка <СЛЕВА> "пустышки"
            else if (emptyChip.curCol - 1 == clickedChip.curCol
                    && clickedChip.curRow == emptyChip.curRow)
            {
                _isTableCanClicked = false;
                canSwap = true;
            }
            // Eсли кликнутая фишка <СПРАВА> "пустышки"
            else if (emptyChip.curCol + 1 == clickedChip.curCol
                    && clickedChip.curRow == emptyChip.curRow)
            {
                _isTableCanClicked = false;
                canSwap = true;
            }
            else
            {
                _isTableCanClicked = true;
                canSwap = false;
            }

            if(canSwap)
            {
                mixTwoChips(clickedChip, emptyChip, false);
                swap(clickedChip, emptyChip);
                _view.dispatchEvent(new CustomEvent(CustomEvent.MOVE));
            }
        }
    }

    /* SWAP */
    private function swap(clickedChip:Chip, emptyChip:Chip):void
    {
        var clickedTempX:Number = clickedChip.view.x;
        var clickedTempY:Number = clickedChip.view.y;
        var emptyTempX:Number = emptyChip.view.x;
        var emptyTempY:Number = emptyChip.view.y;
        emptyChip.view.x = clickedTempX;
        emptyChip.view.y = clickedTempY;
        TweenLite.to(clickedChip.view, 0.2, {y:emptyTempY, x:emptyTempX, onComplete:endAnimation});
    }

    /* END ANIMATION */
    private function endAnimation():void
    {
        _isTableCanClicked = true;
        checkingWin();
    }

    /* CHECKING WIN */
    public function checkingWin():void
    {
        var functionAvailable:Boolean = true;
        // проверка на выигрыш
        for (var row:uint = 0; row < _fieldSize; row++)
        {
            for (var col:int = 0; col < _fieldSize; col++)
            {
                var curChip:Chip = _chips[row][col];
                // проверка на истинное значение ряда и столбца фишки
                // если хотя бы одна фишка не соответствует истинной позиции - не победа
                if (!curChip.checkingState())
                {
                    functionAvailable = false;
                }
            }
        }
        if (functionAvailable)
        {
            _view.dispatchEvent(new CustomEvent(CustomEvent.WIN));
        }
    }

    /* GET CHIP BY ID */
    private function getChipById(id:int):Chip
    {
        for (var row:uint = 0; row < _fieldSize; row++)
        {
            for (var col:uint = 0; col < _fieldSize; col++)
            {
                var chip:Chip = _chips[row][col];
                if(chip.id == id) return chip;
            }
        }
        return null;
    }
}
}
