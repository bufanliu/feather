package org.feather.lib.interactive
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import org.feather.lib.core.BaseUIComponent;
	import org.feather.lib.event.ExtMouseEvent;
	import org.feather.utils.Debugger;
	import org.feather.utils.events.ExtEvent;
	import org.feather.utils.events.ExtEventDispatcher;

	/**
	 * 所有按钮组件的基类，用于定义所有按钮共有的属性和方法。 此类将处理绘制状态以及对按钮事件的调度
	 * @author Aaron Wei
	 * @email weilong1@staff.sina.com.cn
	 * @msn asianfalcon@msn.com
	 * @qq 120020062
	 * @copy Copyright © 1996 - 2012 SINA Corporation, All Rights Reserved
	 */
	public class BaseButton extends BaseUIComponent
	{
		protected var _skin:Object;
		protected var _defaultSkin:Object;
		protected var _upSkin:*;
		protected var _overSkin:*;
		protected var _downSkin:*;
		protected var _disabledSkin:*;
		protected var _reactionArea:*;
		protected var _background:DisplayObject;
		protected var _firstRender:Boolean;

		public function BaseButton(style:Object=null)
		{
			super(style);
		}

		override protected function initData():void
		{
			super.initData();
			_firstRender=true;
			//_defaultSkin={up: null, over: null, down: null, disabled: null, reaction: null};
			_defaultSkin={up: new Button_upSkin, over: new Button_overSkin, down: new Button_downSkin, disabled: new Button_disabledSkin, reaction: new Button_upSkin};
			_style.skin=_skin=_style && _style.skin ? _style.skin : _defaultSkin;
			_upSkin=_skin && _skin.up ? _skin.up : _defaultSkin.up;
			_overSkin=_skin && _skin.over ? _skin.over : _defaultSkin.over;
			_downSkin=_skin && _skin.down ? _skin.down : _defaultSkin.down;
			_disabledSkin=_skin && _skin.disabled ? _skin.disabled : _defaultSkin.disabled;
			_reactionArea=_skin && _skin.reaction ? _skin.reaction : _defaultSkin.reaction;
			Debugger.debug(_disabledSkin, this);
		}

		override public function render(e:Event=null):void
		{
			if (((e && e.eventPhase != 3) || !e) && this.parent)
			{
				if (_disabledSkin && !contains(_disabledSkin))
				{
					addChildAt(_disabledSkin, 0);
				}
				if (_downSkin && !contains(_downSkin))
				{
					addChildAt(_downSkin, 1);
				}
				if (_overSkin && !contains(_overSkin))
				{
					addChildAt(_overSkin, 2);
				}
				if (_upSkin && !contains(_upSkin))
				{
					addChildAt(_upSkin, 3);
				}
				if (_reactionArea && !contains(_reactionArea))
				{
					addChildAt(_reactionArea, 4);
				}
				if (_firstRender)
				{
					_firstRender=false;
					_upSkin.visible=_enabled;
					_overSkin.visible=false;
					_downSkin.visible=false;
					_disabledSkin.visible=!_enabled;
					_reactionArea.visble=true;
					_reactionArea.alpha=0;
				}
				registerButtonEvent();
			}
		}

		protected function registerButtonEvent():void
		{
			if (_reactionArea)
			{
				_reactionArea.hasEventListener(MouseEvent.MOUSE_OVER) ? null : _reactionArea.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
				_reactionArea.hasEventListener(MouseEvent.MOUSE_DOWN) ? null : _reactionArea.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
				_reactionArea.hasEventListener(MouseEvent.MOUSE_UP) ? null : _reactionArea.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
				_reactionArea.hasEventListener(MouseEvent.MOUSE_OUT) ? null : _reactionArea.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
				_reactionArea.hasEventListener(MouseEvent.CLICK) ? null : _reactionArea.addEventListener(MouseEvent.CLICK, onClick);
				_reactionArea.hasEventListener(MouseEvent.DOUBLE_CLICK) ? null : _reactionArea.addEventListener(MouseEvent.DOUBLE_CLICK, onDoubleClick);
			}
		}

		protected function onMouseOver(e:MouseEvent):void
		{
			_upSkin.visible=false;
			_overSkin.visible=_enabled;
			_downSkin.visible=false;
			_disabledSkin.visible=!_enabled;
			_enabled ? new ExtEventDispatcher().dispatch(new ExtMouseEvent(MouseEvent.MOUSE_OVER), {}) : null;
		}

		protected function onMouseDown(e:MouseEvent):void
		{
			_upSkin.visible=false;
			_overSkin.visible=false;
			_downSkin.visible=_enabled;
			_disabledSkin.visible=!enabled;
			_enabled ? new ExtEventDispatcher().dispatch(new ExtMouseEvent(MouseEvent.MOUSE_DOWN), {}) : null;
		}

		protected function onMouseUp(e:MouseEvent):void
		{
			_upSkin.visible=false;
			_overSkin.visible=_enabled;
			_downSkin.visible=false;
			_disabledSkin.visible=!enabled;
			_enabled ? new ExtEventDispatcher().dispatch(new ExtMouseEvent(MouseEvent.MOUSE_UP), {}) : null;
		}

		protected function onMouseOut(e:MouseEvent):void
		{
			_upSkin.visible=_enabled;
			_overSkin.visible=false;
			_downSkin.visible=false;
			_disabledSkin.visible=!_enabled;
			_enabled ? new ExtEventDispatcher().dispatch(new ExtMouseEvent(MouseEvent.MOUSE_OUT), {}) : null;
		}

		protected function onMouseMove(e:MouseEvent):void
		{
			_enabled ? new ExtEventDispatcher().dispatch(new ExtMouseEvent(MouseEvent.MOUSE_MOVE), {}) : null;
		}

		protected function onMouseWheel(e:MouseEvent):void
		{
			_enabled ? new ExtEventDispatcher().dispatch(new ExtMouseEvent(MouseEvent.MOUSE_WHEEL), {}) : null;
		}

		protected function onRollOver(e:MouseEvent):void
		{
			_enabled ? new ExtEventDispatcher().dispatch(new ExtMouseEvent(MouseEvent.ROLL_OVER), {}) : null;
		}

		protected function onRollOut(e:MouseEvent):void
		{
			_enabled ? new ExtEventDispatcher().dispatch(new ExtMouseEvent(MouseEvent.ROLL_OUT), {}) : null;
		}

		protected function onClick(e:MouseEvent):void
		{
			_enabled ? new ExtEventDispatcher().dispatch(new ExtMouseEvent(MouseEvent.CLICK), {}) : null;
		}

		protected function onDoubleClick(e:MouseEvent):void
		{
			_enabled ? new ExtEventDispatcher().dispatch(new ExtMouseEvent(MouseEvent.DOUBLE_CLICK), {}) : null;
		}

		override public function get enabled():Boolean
		{
			return _enabled;
		}

		override public function set enabled(boo:Boolean):void
		{
			useHandCursor=buttonMode=_enabled=boo;
		}
	}
}