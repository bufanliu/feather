package org.feather.lib.controls
{
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;

	/**
	 * <br><b>SimpelButton扩展类</b></br>
	 * 增加enabled为false状态下的灰色显示，方便按钮禁用；
	 * @author Aaron Wei
	 * @email weilong1@staff.sina.com.cn
	 * @msn asianfalcon@msn.com
	 * @qq 120020062
	 * @copy Copyright © 1996 - 2012 SINA Corporation, All Rights Reserved
	 */
	public class ExtendedSimpleButton extends SimpleButton
	{
		protected var _enabled:Boolean;
		protected var _upState:DisplayObject;
		protected var _overState:DisplayObject;
		protected var _downState:DisplayObject;
		protected var _hitTestState:DisplayObject;
		protected var _disableState:DisplayObject;

		public function ExtendedSimpleButton(upState:DisplayObject=null, overState:DisplayObject=null, downState:DisplayObject=null, hitTestState:DisplayObject=null, disableState:DisplayObject=null)
		{
			super(upState, overState, downState, hitTestState);
			_enabled=true;
			_upState=upState;
			_overState=overState;
			_downState=downState;
			_hitTestState=hitTestState;
			_disableState=disableState;
		}

		public function get disableState():DisplayObject
		{
			return _disableState as DisplayObject;
		}

		public function set disableState(obj:DisplayObject):void
		{
			_disableState=obj as DisplayObject;
		}

		override public function get enabled():Boolean
		{
			return super.enabled;
		}

		override public function set enabled(value:Boolean):void
		{
			_enabled=super.enabled=value;
			if (value)
			{
				if (_upState)
				{
					upState=_upState;
				}
			}
			else
			{
				if (_disableState)
				{
					upState=_disableState;
				}
			}
		}
	}
}