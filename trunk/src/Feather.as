package
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	import org.feather.lib.core.BaseUIComponent;
	import org.feather.lib.core.IBaseUIComponent;
	import org.feather.lib.core.Repainter;
	import org.feather.lib.interactive.BaseButton;
	import org.feather.lib.layout.BaseBorder;
	import org.feather.lib.layout.Container;
	import org.feather.lib.layout.Label;
	import org.feather.lib.layout.LoaderContainer;
	import org.feather.lib.layout.ProSprite;
	import org.feather.utils.Debugger;
	import org.feather.utils.data.HashSetter;
	import org.feather.utils.display.Layout;
	import org.feather.utils.events.ExtEvent;

	[SWF(width="400", height="300", backgroundColor="#FFFFFF", frameRate="25")]
	public class Feather extends Sprite
	{
		public function Feather()
		{
			/*var a:Label=new Label();
			   a.selectable=true;
			   a.autoSize=TextFieldAutoSize.CENTER;

			   var format:TextFormat=new TextFormat();
			   format.font="微软雅黑";
			   format.size=24;
			   format.bold=true;
			   format.color=0xFF0000;

			   a.textField.defaultTextFormat=format;
			   a.textField.background=true;
			   a.textField.backgroundColor=0xFFFF00;
			   a.text="Label";
			   addChild(a);
			 stage.invalidate();*/

			var b:BaseButton=new BaseButton();
			b.buttonMode=true;
			b.useHandCursor=true;
			addChild(b);

			var e:ExtEvent=new ExtEvent("aaa");

		}
	}
}