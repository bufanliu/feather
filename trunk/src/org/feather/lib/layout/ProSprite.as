package org.feather.lib.layout
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Rectangle;

	import org.feather.config.LayoutConfig;
	import org.feather.lib.core.BaseUIComponent;
	import org.feather.lib.layout.SpriteFormat;
	import org.feather.utils.Debugger;
	import org.feather.utils.Tools;
	import org.feather.utils.display.Drawer;
	import org.feather.lib.core.BaseUIComponent;
	import org.feather.lib.core.UIComponentStyle;

	/**
	 * 增进的Sprite类
	 * @author Aaron Wei
	 * @email weilong1@staff.sina.com.cn
	 * @msn asianfalcon@msn.com
	 * @qq 120020062
	 * @copy Copyright © 1996 - 2012 SINA Corporation, All Rights Reserved
	 */
	public class ProSprite extends BaseUIComponent
	{
		/** 样式属性*/
		protected var _rw:Number;
		protected var _rh:Number;
		protected var _bgColor:uint;
		protected var _bgAlp:Number;
		protected var _padding:Object;
		protected var _top:Number;
		protected var _bottom:Number;
		protected var _left:Number;
		protected var _right:Number;
		protected var _hitArea:Sprite;
		protected var _hitRect:Rectangle;
		protected var _hitX:Number;
		protected var _hitY:Number;
		protected var _hitW:Number;
		protected var _hitH:Number;

		/**
		 * 显示容器基类，接收Object类型参数，
		 * @param w：容器宽
		 * @param h：容器高
		 * @param bgColor：背景色
		 * @param bgAlpha：背景透明度
		 * @param rect：交互区域
		 * @param padding：里衬
		 */
		public function ProSprite(style:Object=null):void
		{
			super(style);
		}

		override protected function commitProperties():void
		{
			super.commitProperties();
			_style.rw=_rw=(_style && (_style.rw || _style.rw === 0)) ? _style.rw : LayoutConfig.DEFAULT_RW;
			_style.rh=_rh=(_style && (_style.rh || _style.rh === 0)) ? _style.rh : LayoutConfig.DEFAULT_RH;
			_style.bgColor=_bgColor=(_style && (_style.bgColor || _style.bgColor == 0)) ? _style.bgColor : LayoutConfig.DEFAULT_BG_COLOR;
			_style.bgAlp=_bgAlp=(_style && (_style.bgAlp || _style.bgAlp === 0)) ? _style.bgAlp : LayoutConfig.DEFAULT_BG_ALP;
			_style.hitRect=_hitRect=(_style && _style.hitRect) ? _style.hitRect : null;
			_style.padding=_padding=(_style && _style.padding) ? _style.padding : null;
			_top=(_padding && _padding.top) ? _padding.top : 0;
			_bottom=(_padding && _padding.bottom) ? _padding.bottom : 0;
			_left=(_padding && _padding.left) ? _padding.left : 0;
			_right=(_padding && _padding.right) ? _padding.right : 0;
		}

		private function initReaction():void
		{
			if (_hitRect != null)
			{
				_hitArea=new Sprite();
				_hitX=_hitRect.x;
				_hitY=_hitRect.y;
				_hitW=_hitRect.width;
				_hitH=_hitRect.height;
				Drawer.drawRectArea(_hitArea, 0, 0, _hitW, _hitH, 0xFF00FF, 1, 0);
				addChild(_hitArea);
				_hitArea.x=_hitX;
				_hitArea.y=_hitY;
				this.hitArea=_hitArea;
			}
		}

		/**
		 *渲染、绘制
		 */
		override protected function draw(e:Event=null):void
		{
			if (((e && e.eventPhase != 3) || !e) && this.parent)
			{
				super.draw();
				Debugger.debug("validateNow:" + e, this);
				Drawer.drawRectArea(this, _startX, _startY, _wsize, _hsize, _bgColor, _bgAlp, _rw, _rh);
				initReaction();
			}
		}

		override public function get hitArea():Sprite
		{
			return super.hitArea;
		}

		override public function set hitArea(spr:Sprite):void
		{
			super.hitArea=_hitArea=spr;
		}

		/**
		 *获取容器圆角半径宽
		 * @return 容器圆角半径宽
		 */
		public function get rw():Number
		{
			return _rw;
		}

		/**
		 *设置容器圆角半径宽
		 * @param r：容器圆角半径宽
		 */
		public function set rw(r:Number):void
		{
			if (_rw !== r)
			{
				_changed=true;
				_rw=_style.rw=r;
			}
			validate();
		}

		/**
		 *获取容器圆角半径高
		 * @return 容器圆角半径高
		 */
		public function get rh():Number
		{
			return _rh;
		}

		/**
		 *设置容器圆角半径高
		 * @param r：容器圆角半径高
		 */
		public function set rh(r:Number):void
		{
			if (_rh !== r)
			{
				_changed=true;
				_rh=_style.rh=r;
			}
			validate();
		}

		/**
		 *获取容器背景色
		 * @return 容器背景色
		 */
		public function get bgColor():uint
		{
			return _bgColor;
		}

		/**
		 *设置容器背景色
		 * @param c：容器背景色
		 */
		public function set bgColor(c:uint):void
		{
			if (_bgColor != c)
			{
				_changed=true;
				_bgColor=_style.bgColor=c;
			}
			validate();
		}

		/**
		 *获取容器背景透明度
		 * @return 容器背景透明度
		 */
		public function get bgAlp():Number
		{
			return _bgAlp;
		}

		/**
		 * 设置容器背景透明度
		 * @param a：容器背景透明度
		 */
		public function set bgAlp(a:Number):void
		{
			if (_bgAlp != a)
			{
				_changed=true;
				_bgAlp=_style.bgAlp=a;
			}
			validate();
		}
	}
}