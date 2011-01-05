package org.feather.lib.controls
{
	import flash.events.Event;

	public class Button extends LabelButton
	{
		public function Button(style:Object=null)
		{
			super(style);
		}

		override protected function initialize():void
		{
			_defaultSkin={up: new Button_upSkin, over: new Button_overSkin, down: new Button_downSkin, disabled: new Button_disabledSkin, reaction: new Button_upSkin, label: "Label"};
			super.initialize();
		}

		override protected function commitProperties():void
		{
			_style.wsize=_wsize=(_style && (_style.wsize || _style.wsize === 0)) ? _style.wsize : 80;
			_style.hsize=_hsize=(_style && (_style.hsize || _style.hsize === 0)) ? _style.hsize : 30;
			super.commitProperties();
		}

		/**
		 *渲染、绘制
		 */
		override protected function draw(e:Event=null):void
		{
			super.draw();
			_upSkin.width=_overSkin.width=_downSkin.width=_disabledSkin.width=_reactionArea.width=_wsize;
			_upSkin.height=_overSkin.height=_downSkin.height=_disabledSkin.height=_reactionArea.height=_hsize;
		}
	}
}