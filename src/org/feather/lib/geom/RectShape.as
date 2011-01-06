package org.feather.lib.geom
{
	import flash.display.Shape;
	import flash.events.Event;

	import org.feather.utils.Debugger;
	import org.feather.utils.Drawer;

	/**
	 *  矩形形状类，不提供容器和交互功能，只显示
	 * @author Aaron Wei
	 * @email weilong1@staff.sina.com.cn
	 * @msn asianfalcon@msn.com
	 * @qq 120020062
	 * @copy Copyright © 1996 - 2012 SINA Corporation, All Rights Reserved
	 */

	public class RectShape extends Shape
	{
		protected var _origin:Point;
		protected var _wsize:Number;
		protected var _hsize:Number;
		protected var _color:uint;
		protected var _alp:Number;
		
		private static const DEFAULT_BG_COLOR:uint=0xEEEEEE;
		private static const DEFAULT_BG_ALP:Number=1;
		private static const DEFAULT_BORDER_COLOR:uint=0xDDDDDD;
		private static const DEFAULT_BORDER_ALP:Number=1;
		private static const DEFAULT_THICKNESS:Number=1;
		private static const DEFAULT_W:Number=320;
		private static const DEFAULT_H:Number=240;
		private static const DEFAULT_RW:Number=0;
		private static const DEFAULT_RH:Number=0;

		public function RectShape(style:Object=null):void
		{
			initData(o, w, h, color, alp);
			registerRenderEvent();
		}

		protected function registerRenderEvent():void
		{
			if (!this.hasEventListener(Event.RENDER))
			{
				this.addEventListener(Event.RENDER, render);
			}
			if (!this.hasEventListener(Event.ADDED))
			{
				this.addEventListener(Event.ADDED, render);
			}
		}

		/**
		 * 设置组件数据信息
		 * @param info
		 */
		protected function initData(o:Point=null, w:Number=320, h:Number=240, color:uint=0xEEEEEE, alp:Number=1):void
		{
			_origin=o ? o : new Point(0, 0);
			_wsize=w;
			_hsize=h;
			_color=color;
			_alp=alp;
		}

		/**
		 * 渲染UI
		 */
		public function render(e:Event=null):void
		{
			Debugger.debug("render:" + e, this);
			if (((e && e.eventPhase != 3) || !e) && this.parent)
			{
				Drawer.clear(this);
				Drawer.drawRectArea(this, _origin.x, _origin.y, _wsize, _hsize, _color, _alp);
			}
		}

		/**
		 *清除组件显示
		 */
		public function invalidate():void
		{
			Drawer.clear(this);
		}

		public function get wsize():Number
		{
			return _wsize;
		}

		public function set wsize(w:Number):void
		{
			_wsize=w;
			render();
		}

		public function get hsize():Number
		{
			return _hsize;
		}

		public function set hsize(h:Number):void
		{
			_hsize=h;
			render();
		}

		public function get color():uint
		{
			return _color;
		}

		public function set color(c:uint):void
		{
			_color=c;
			render();
		}

		public function get alp():Number
		{
			return _alp;
		}

		public function set alp(a:Number):void
		{
			_alp=a;
			render();
		}
	}
}