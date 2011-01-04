package org.feather.lib.layout
{
	import flash.display.LineScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;

	import org.feather.config.LayoutConfig;
	import org.feather.utils.Debugger;
	import org.feather.utils.geom.Drawer;
	import org.feather.lib.core.UIComponentStyle;

	/**
	 * 容器类
	 * @author Aaron Wei
	 * @email weilong1@staff.sina.com.cn
	 * @msn asianfalcon@msn.com
	 * @qq 120020062
	 * @copy Copyright © 1996 - 2012 SINA Corporation, All Rights Reserved
	 */

	public class Container extends ProSprite
	{
		protected var _border:BaseBorder;
		protected var _borderColor:uint;
		protected var _borderAlp:Number;
		protected var _thickness:Number
		protected var _borderLayout:String;

		protected var _pixelHinting:Boolean;
		protected var _scaleMode:String;
		protected var _caps:String;
		protected var _joints:String;
		protected var _miterLimit:Number;

		public function Container(style:Object=null):void
		{
			super(style);
		}

		override protected function commitProperties():void
		{
			super.commitProperties();
			_style.borderColor=_borderColor=(_style && (_style.borderColor || _style.borderColor == 0)) ? _style.borderColor : LayoutConfig.DEFAULT_BORDER_COLOR;
			_style.borderAlp=_borderAlp=(_style && (_style.borderAlp || _style.borderAlp === 0)) ? _style.borderAlp : LayoutConfig.DEFAULT_BORDER_ALP;
			_style.thickness=_thickness=(_style && (_style.thickness || _style.thickness === 0)) ? _style.thickness : LayoutConfig.DEFAULT_THICKNESS;
			_style.borderLayout=_borderLayout=(_style && _style.borderLayout) ? _style.borderLayout : LayoutConfig.DEFAULT_BORDER_LAYOUT;
			_style.pixelHinting=_pixelHinting=(_style && _style.pixelHinting) ? _style.pixelHinting : LayoutConfig.DEFAULT_PIXELHINTING;
			_style.scaleMode=_scaleMode=(_style && _style.scaleMode) ? _style.scaleMode : LayoutConfig.DEFAULT_SCALEMODE;
			_style.caps=_caps=(_style && _style.caps) ? _style.caps : LayoutConfig.DEFAULT_CAPS;
			_style.joints=_joints=(_style && _style.joints) ? _style.joints : LayoutConfig.DEFAULT_JOINTS;
			_style.miterLimit=_miterLimit=(_style && _style.miterLimit) ? _style.miterLimit : LayoutConfig.DEFAULT_MITERLIMIT;
		}

		override protected function creatChildren():void
		{
			super.creatChildren();
			_border=_border || new BaseBorder(_style);
		}

		/**
		 * 渲染UI
		 */
		override public function validateNow(e:Event=null):void
		{
			if (((e && e.eventPhase != 3) || !e) && this.parent)
			{
				Debugger.debug("render:" + e, this);
				super.validateNow(e);
				if (_border)
				{
					contains(_border) ? null : addChild(_border);
					_border.style=_style;
				}
			}
		}

		/**
		 *获取边框
		 * @return 边框
		 */
		public function get border():BaseBorder
		{
			return _border;
		}

		/**
		 *获取边框色粗细
		 * @return 边框粗细
		 */
		public function get thickness():Number
		{
			return _thickness;
		}

		/**
		 *获取边框色粗细
		 * @return 边框粗细
		 */
		public function set thickness(t:Number):void
		{
			if (_thickness != t)
			{
				_changed=true;
				_thickness=_style.thickness=t;
			}
			validate();
		}

		/**
		 *获取边框色布局
		 * @return 边框布局
		 */
		public function get borderLayout():String
		{
			return _borderLayout;
		}

		/**
		 *设置边框布局
		 * @return 边框布局
		 */
		public function set borderLayout(m:String):void
		{
			if (_borderLayout != m)
			{
				_changed=true;
				_borderLayout=_style.borderLayout=m;
			}
			validate();
		}

		/**
		 *获取边框色
		 * @return 边框色
		 */
		public function get borderColor():uint
		{
			return _borderColor;
		}

		/**
		 *设置边框色
		 * @param c：边框色
		 */
		public function set borderColor(c:uint):void
		{
			if (_borderColor != c)
			{
				_changed=true;
				_borderColor=_style.borderColor=c;
			}
			validate();
		}

		/**
		 *获取边框透明度
		 * @return 边框透明度
		 */
		public function get borderAlp():Number
		{
			return _borderAlp;
		}

		/**
		 * 设置边框透明度
		 * @param a：边框透明度
		 */
		public function set borderAlp(a:Number):void
		{
			if (_borderAlp != a)
			{
				_changed=true;
				_borderAlp=_style.borderAlp=a;
			}
			validate();
		}
	}
}