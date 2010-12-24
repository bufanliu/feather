package org.feather.lib.interactive
{
	import flash.display.DisplayObject;
	
	import org.feather.lib.core.BaseUIComponent;
	
	public class ExtendedButton extends BaseUIComponent
	{
		protected var _enabled:Boolean;
		protected var _upState:DisplayObject;
		protected var _overState:DisplayObject;
		protected var _downState:DisplayObject;
		protected var _hitTestState:DisplayObject;
		protected var _disableState:DisplayObject;
		protected var _tip:DisplayObject;
		protected var _labelText:TextField;
		protected var _label:String;
		
		public function ExtendedButton(info:Object):void
		{
			super();
			_enabled=true;
			_upState=upState;
			_overState=overState;
			_downState=downState;
			_hitTestState=hitTestState;
			_disableState=disableState;
		}
		
		/**
		 * 设置组件数据信息
		 * @param info
		 */
		override protected function initData():void
		{
			_wsize=(_format && !isNaN(_format.wsize)) ? _format.wsize : LayoutConfig.DEFAULT_W;
			_hsize=(_format && !isNaN(_format.hsize)) ? _format.hsize : LayoutConfig.DEFAULT_H;
			_rw=(_format && !isNaN(_format.rw)) ? _format.rw : LayoutConfig.DEFAULT_RW;
			_rh=(_format && !isNaN(_format.hsize)) ? _format.rh : LayoutConfig.DEFAULT_RH;
		}
	}
}