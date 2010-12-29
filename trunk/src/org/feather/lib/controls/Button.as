package org.feather.lib.controls
{
	public class Button extends LabelButton
	{
		public function Button(style:Object=null)
		{
			super(style);
		}
		override protected function initialize():void
		{
			_defaultSkin={up: new Button_upSkin, over: new Button_overSkin, down: new Button_downSkin, disabled: new Button_disabledSkin, reaction: new Button_upSkin,label:"Label"};
			super.initialize();
		}
	}
}