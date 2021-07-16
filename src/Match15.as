package {

import flash.display.Sprite;
import flash.text.TextField;

[SWF (width="550", height="385")]
public class Match15 extends Sprite
{
    private var _gameController:GameController;

    public function Match15()
    {
        _gameController = new GameController(stage);
        _gameController.init();
    }
}
}
