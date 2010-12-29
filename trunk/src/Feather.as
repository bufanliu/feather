package
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	import org.feather.lib.controls.BaseButton;
	import org.feather.lib.controls.Button;
	import org.feather.lib.controls.LabelButton;
	import org.feather.lib.core.BaseUIComponent;
	import org.feather.lib.core.IBaseUIComponent;
	import org.feather.lib.core.Repainter;
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
			b.enabled=true;
			addChild(b);
			Layout.setCenterOO(b, stage);

			var c:LabelButton=new LabelButton();
			c.buttonMode=true;
			c.useHandCursor=true;
			c.enabled=true;
			addChild(c);
			Layout.setCenterOO(c, stage);
			c.y+=20;

			var d:Button=new Button();
			d.buttonMode=true;
			d.useHandCursor=true;
			d.enabled=true;
			addChild(d);
			Layout.setCenterOO(d, stage);
			d.y+=40;
			d.width=30;
			d.height=10;

		}
	}
}