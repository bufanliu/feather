package org.feather.lib.core
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;

	import org.feather.config.LayoutConfig;
	import org.feather.utils.Debugger;
	import org.feather.utils.Tools;
	import org.feather.utils.data.Option;
	import org.feather.utils.display.Drawer;

	/**
	 * 显示组件基础类
	 * @author Aaron Wei
	 * @email weilong1@staff.sina.com.cn
	 * @msn asianfalcon@msn.com
	 * @qq 120020062
	 * @copy Copyright © 1996 - 2012 SINA Corporation, All Rights Reserved
	 */
	public class BaseUIComponent extends Sprite implements IBaseUIComponent
	{
		protected var _isParamNull:Boolean;
		protected var _enabled:Boolean;
		protected var _style:Object;
		protected var _startX:Number;
		protected var _startY:Number;
		protected var _wsize:Number;
		protected var _hsize:Number;
		protected var _rw:Number;
		protected var _rh:Number;
		protected var _stage:Stage;
		protected var _isValidate:Boolean;

		/**
		 * 显示组件基础类
		 */
		public function BaseUIComponent(style:Object=null):void
		{
			_isParamNull=style ? false : true;
			_style=style ? style : new Object();
			initData();
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
		protected function initData():void
		{
			_style.startX=_startX=(_style && (_style.startX || _style.startX === 0)) ? _style.startX : 0;
			_style.startY=_startY=(_style && (_style.startY || _style.startY === 0)) ? _style.startY : 0;
			_style.wsize=_wsize=(_style && (_style.wsize || _style.wsize === 0)) ? _style.wsize : LayoutConfig.DEFAULT_W;
			_style.hsize=_hsize=(_style && (_style.hsize || _style.hsize === 0)) ? _style.hsize : LayoutConfig.DEFAULT_H;
			_style.rw=_rw=(_style && (_style.rw || _style.rw === 0)) ? _style.rw : LayoutConfig.DEFAULT_RW;
			_style.rh=_rh=(_style && (_style.rh || _style.rh === 0)) ? _style.rh : LayoutConfig.DEFAULT_RH;
			_style.enabled=_enabled=(_style&&_style.enabled==false)?false:true;
			_style.isValidate=_isValidate=_style && _style.isValidate ? _style.isValidate : false;
			//new Option(_style).apply(this);
		}

		/**
		 * 渲染UI
		 */
		public function render(e:Event=null):void
		{
		}

		protected function optionRender():void
		{
			if (_isValidate)
			{
				render();
			}
			else
			{
				return;
			}
		}

		/**
		 *清除组件显示
		 */
		public function invalidate():void
		{
			Drawer.clear(this);
		}

		/**
		 * render是否生效
		 * <br>true：实时渲染</br>
		 * <br>false：定时渲染</br>
		 * @return
		 */
		public function get isValidate():Boolean
		{
			return _isValidate as Boolean;
		}

		public function set isValidate(boo:Boolean):void
		{
			_style.isValidate=_isValidate=boo;
		}

		/**
		 * 设置组件样式
		 * @param info：样式信息
		 */
		public function set style(info:Object):void
		{
			_style=info;
			initData();
			optionRender();
		}

		/**
		 * 获取组件样式
		 * @return
		 */
		public function get style():Object
		{
			return _style;
		}

		/**
		 * 将组件移动到其父项内的指定位置
		 */
		public function move(x:Number, y:Number):void
		{
			this.x=x;
			this.y=y;
		}

		/**
		 * 设置组件相对外部宽高
		 * @param w：组件相对外部宽；
		 * @param h：组件相对外部高；
		 */
		public function setSize(w:Number, h:Number):void
		{
			this.width=w;
			this.height=h;
		}

		/**
		 * 设置组件相对内部宽高
		 * @param w：组件相对内部宽；
		 * @param h：组件相对内部高；
		 */
		public function setSelfSize(ws:Number, hs:Number):void
		{
			this.wsize=ws;
			this.hsize=hs;
		}

		/**
		 *获取组件左上角顶点相对自坐标系的x坐标
		 * @return：组件左上角顶点相对自坐标系的x坐标
		 */
		public function get startX():Number
		{
			return _startX;
		}

		/**
		 *获取组件左上角顶点相对自坐标系的y坐标
		 * @return：组件左上角顶点相对自坐标系的y坐标
		 */
		public function get startY():Number
		{
			return _startY;
		}

		/**
		 *获取组件自宽
		 * @return：组件自宽
		 */
		public function get wsize():Number
		{
			return _wsize;
		}

		/**
		 *设置组件自宽
		 * @param w：组件自宽
		 */
		public function set wsize(w:Number):void
		{
			_wsize=_style.wsize=w;
			optionRender();
		}

		/**
		 *获取组件自高
		 * @return：组件自高
		 */
		public function get hsize():Number
		{
			return _hsize;
		}

		/**
		 *设置组件自高
		 * @param h：组件自高
		 */
		public function set hsize(h:Number):void
		{
			_hsize=_style.hsize=h;
			optionRender();
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
			_rw=_style.rw=r;
			optionRender();
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
			_rh=_style.rh=r;
			optionRender();
		}

		public function get enabled():Boolean
		{
			return _enabled;
		}

		public function set enabled(boo:Boolean):void
		{
			_enabled=boo;
		}
	}
}