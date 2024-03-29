package org.feather.lib.geom
{
	import flash.events.Event;
	
	import org.feather.config.LayoutConfig;
	import org.feather.lib.core.BaseUIComponent;
	import org.feather.utils.display.Drawer;
	import org.feather.utils.Debugger;
	import org.feather.lib.layout.BorderFillLayout;
	
	/**
	 * 提供带有交互和容器功能的几何图形
	 * @author Aaron Wei
	 * @email weilong1@staff.sina.com.cn
	 * @msn asianfalcon@msn.com
	 * @qq 120020062
	 * @copy Copyright © 1996 - 2012 SINA Corporation, All Rights Reserved
	 */
	public class CircleComponent extends BaseUIComponent
	{
		/** 样式属性*/
		protected var _radius:Number;
		protected var _bgColor:uint;
		protected var _bgAlp:Number;
		protected var _borderColor:uint;
		protected var _borderAlp:Number;
		protected var _thickness:Number;
		protected var _layout:String;
		protected var _pixelHinting:Boolean;
		protected var _scaleMode:String;
		protected var _caps:String;
		protected var _joints:String;
		protected var _miterLimit:Number;
		
		public function CircleComponent(style:Object=null)
		{
			super(style);
		}
		
		override protected function commitProperties():void
		{
			super.commitProperties();
			_style.radius=_radius=(_style && (_style.radius || _style.radius === 0)) ? _style.radius : LayoutConfig.DEFAULT_RADIUS;
			_style.bgColor=_bgColor=(_style && (_style.bgColor || _style.bgColor === 0)) ? _style.bgColor : LayoutConfig.DEFAULT_BG_COLOR;
			_style.bgAlp=_bgAlp=(_style && (_style.bgAlp || _style.bgAlp === 0)) ? _style.bgAlp : LayoutConfig.DEFAULT_BG_ALP;
			_style.borderColor=_borderColor=(_style && (_style.borderColor || _style.borderColor === 0)) ? _style.borderColor : LayoutConfig.DEFAULT_BORDER_COLOR;
			_style.borderAlp=_borderAlp=(_style && (_style.borderAlp || _style.borderAlp === 0)) ? _style.borderAlp : LayoutConfig.DEFAULT_BORDER_ALP;
			_style.thickness=_thickness=(_style && (_style.thickness || _style.thickness === 0)) ? _style.thickness : LayoutConfig.DEFAULT_THICKNESS;
			_style.layout=_layout=(_style && _style.borderLayout) ? _style.borderLayout : BorderFillLayout.INNER;
			_style.pixelHinting=_pixelHinting=(_style && _style.pixelHinting) ? _style.pixelHinting : LayoutConfig.DEFAULT_PIXELHINTING;
			_style.scaleMode=_scaleMode=(_style && _style.scaleMode) ? _style.scaleMode : LayoutConfig.DEFAULT_SCALEMODE;
			_style.caps=_caps=(_style && _style.caps) ? _style.caps : LayoutConfig.DEFAULT_CAPS;
			_style.joints=_joints=(_style && _style.joints) ? _style.joints : LayoutConfig.DEFAULT_JOINTS;
			_style.miterLimit=_miterLimit=(_style && _style.miterLimit) ? _style.miterLimit : LayoutConfig.DEFAULT_MITERLIMIT;
			Debugger.debug(_thickness,this);
		}
		
		override protected function draw(e:Event=null):void
		{
			Drawer.drawCircle(this, 0, 0, _radius, _bgColor, _bgAlp, _borderColor, _borderAlp, _thickness, _layout);
		}
		
		/**
		 *获取圆半径
		 * @return 圆半径
		 */
		public function get radius():Number
		{
			return _radius;
		}
		
		/**
		 * 设置圆半径
		 * @param a：圆半径
		 */
		public function set radius(r:Number):void
		{
			if (_radius != r)
			{
				_changed=true;
				_radius=_style.radius=r;
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
			return _layout;
		}
		
		/**
		 *设置边框布局
		 * @return 边框布局
		 */
		public function set borderLayout(m:String):void
		{
			if (_layout != m)
			{
				_changed=true;
				_layout=_style.borderLayout=m;
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