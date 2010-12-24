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

		public function BaseButton(style:Object=null)
		{
			super(style);
		}

		override protected function initData():void
		{
			super.initData();
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
					addChild(_disabledSkin);
				}
				if (_downSkin && !contains(_downSkin))
				{
					addChild(_downSkin);
				}
				if (_overSkin && !contains(_overSkin))
				{
					addChild(_overSkin);
				}
				if (_upSkin && !contains(_upSkin))
				{
					addChild(_upSkin);
				}
				if (_reactionArea && !contains(_reactionArea))
				{
					addChild(_reactionArea);
				}
				_disabledSkin.visible=
				_upSkin.visible=
				_overSkin.visible=
				_downSkin.visible=
				_reactionArea.visible=
				registerButtonEvent();
			}
		}

		protected function registerButtonEvent():void
		{
			_reactionArea.addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
			_reactionArea.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			_reactionArea.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			_reactionArea.addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
			_reactionArea.addEventListener(MouseEvent.CLICK, onClick);
			_reactionArea.addEventListener(MouseEvent.DOUBLE_CLICK, onDoubleClick);
		}

		protected function onMouseOver(e:MouseEvent):void
		{
			_upSkin.visible=false;
			_overSkin.visible=true;
			_downSkin.visible=false;
			_disabledSkin.visible=false;
			new ExtEventDispatcher().dispatch(new ExtMouseEvent(MouseEvent.MOUSE_OVER), {});
		}

		protected function onMouseDown(e:MouseEvent):void
		{
			_upSkin.visible=false;
			_overSkin.visible=false;
			_downSkin.visible=true;
			_disabledSkin.visible=false;
			new ExtEventDispatcher().dispatch(new ExtMouseEvent(MouseEvent.MOUSE_DOWN), {});
		}

		protected function onMouseUp(e:MouseEvent):void
		{
			_upSkin.visible=false;
			_overSkin.visible=true;
			_downSkin.visible=false;
			_disabledSkin.visible=false;
			new ExtEventDispatcher().dispatch(new ExtMouseEvent(MouseEvent.MOUSE_UP), {});
		}

		protected function onMouseOut(e:MouseEvent):void
		{
			_upSkin.visible=true;
			_overSkin.visible=false;
			_downSkin.visible=false;
			_disabledSkin.visible=false;
			new ExtEventDispatcher().dispatch(new ExtMouseEvent(MouseEvent.MOUSE_OUT), {});
		}

		protected function onMouseMove(e:MouseEvent):void
		{
			new ExtEventDispatcher().dispatch(new ExtMouseEvent(MouseEvent.MOUSE_MOVE), {});
		}

		protected function onMouseWheel(e:MouseEvent):void
		{
			new ExtEventDispatcher().dispatch(new ExtMouseEvent(MouseEvent.MOUSE_WHEEL), {});
		}

		protected function onRollOver(e:MouseEvent):void
		{
			new ExtEventDispatcher().dispatch(new ExtMouseEvent(MouseEvent.ROLL_OVER), {});
		}

		protected function onRollOut(e:MouseEvent):void
		{
			new ExtEventDispatcher().dispatch(new ExtMouseEvent(MouseEvent.ROLL_OUT), {});
		}

		protected function onClick(e:MouseEvent):void
		{
			new ExtEventDispatcher().dispatch(new ExtMouseEvent(MouseEvent.CLICK), {});
		}

		protected function onDoubleClick(e:MouseEvent):void
		{
			new ExtEventDispatcher().dispatch(new ExtMouseEvent(MouseEvent.DOUBLE_CLICK), {});
		}
	}
}