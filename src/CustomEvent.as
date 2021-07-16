/**
 * Created by Sith on 22.06.14.
 */
package {
import flash.events.Event;

public class CustomEvent extends Event
{
    public static const WIN:String = "win";
    public static const RESTART:String = "restart";
    public static const MOVE:String = "move";

    /* CONSTRUCTOR */
    public function CustomEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
    {
        super(type, bubbles, cancelable);
    }
}
}
