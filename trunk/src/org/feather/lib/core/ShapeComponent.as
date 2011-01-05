package org.feather.lib.core
{
	import flash.display.Shape;
	import flash.display.Stage;
	import flash.events.Event;
	import org.feather.config.LayoutConfig;
	import org.feather.utils.Drawer;
	import org.feather.utils.Debugger;

	/**
	 * 形状组件基类
	 * @author Aaron Wei
	 * @email weilong1@staff.sina.com.cn
	 * @msn asianfalcon@msn.com
	 * @qq 120020062
	 * @copy Copyright © 1996 - 2012 SINA Corporation, All Rights Reserved
	 */
	public class ShapeComponent extends Shape implements IShapeComponent
	{
		/**
		 * 组件样式
		 * @default
		 */
		protected var _style:Object;
		protected var _startX:Number;
		protected var _startY:Number;
		protected var _stage:Stage;
		/**
		 * 组件初始化参数是否为null的标识
		 * @default
		 */
		protected var _isParamNull:Boolean;
		/**
		 * 是否支持实时渲染
		 * @default
		 */
		protected var _isValidate:Boolean;
		/**
		 * 组件状态是否有改变
		 * @default
		 */
		protected var _changed:Boolean;

		public function ShapeComponent(style:Object=null)
		{
			super();
			_isParamNull=style ? false : true;
			_style=style ? style : new Object();
			initialize();
			registerEvents();
		}

		protected function registerEvents():void
		{
			this.hasEventListener(Event.RENDER) ? null : this.addEventListener(Event.RENDER, onRender);
			this.hasEventListener(Event.ADDED) ? null : this.addEventListener(Event.ADDED, onAdded);
			this.hasEventListener(Event.ADDED_TO_STAGE) ? null : this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.hasEventListener(Event.REMOVED) ? null : this.addEventListener(Event.REMOVED, onRemoved);
			this.hasEventListener(Event.REMOVED_FROM_STAGE) ? null : this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			this.hasEventListener(Event.RESIZE) ? null : this.addEventListener(Event.RESIZE, onResize);
		}

		protected function removeEvents():void
		{
			this.hasEventListener(Event.RENDER) ? this.removeEventListener(Event.RENDER, onRender) : null;
			this.hasEventListener(Event.ADDED) ? this.removeEventListener(Event.ADDED, onAdded) : null;
			this.hasEventListener(Event.ADDED_TO_STAGE) ? this.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage) : null;
			this.hasEventListener(Event.REMOVED) ? this.removeEventListener(Event.REMOVED, onRemoved) : null;
			this.hasEventListener(Event.REMOVED_FROM_STAGE) ? this.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage) : null;
			this.hasEventListener(Event.RESIZE) ? this.removeEventListener(Event.RESIZE, onResize) : null;
		}

		/**
		 * 初始化组件数据
		 * @param info
		 */
		protected function initialize():void
		{
			commitProperties();
		}

		/**
		 * <br>This method's purpose is to commit any values typically set by using</br>
		 * <br>a setter function. Often the commitProperties( ) method is as simple</br>
		 * <br>as calling super.commitProperties( ) and setting the cached values</br>
		 * <br>提交组件所有的属性变化，要么使属性同时更改，要么确保属性按照特定顺序设置</br>
		 */
		protected function commitProperties():void
		{
			_style.startX=_startX=(_style && (_style.startX || _style.startX === 0)) ? _style.startX : 0;
			_style.startY=_startY=(_style && (_style.startY || _style.startY === 0)) ? _style.startY : 0;
			_style.isValidate=_isValidate=_style && _style.isValidate ? _style.isValidate : true;
			_changed=true;
		}

		/**
		 *渲染
		 */
		public function validate(e:Event=null):void
		{
			if (_isValidate && _changed)
			{
				_changed=false;
				validateNow();
			}
			else
			{
				return;
			}
		}

		/**
		 *及时渲染
		 */
		public function validateNow(e:Event=null):void
		{
			invalidate();
		}

		/**
		 *对于非容器类清空意味着清除画布的一切绘制
		 */
		public function invalidate():void
		{
			Drawer.clear(this);
		}

		/**
		 *获取或设置组件是否支持实时渲染
		 */
		public function get isValidate():Boolean
		{
			return _isValidate;
		}

		public function set isValidate(boo:Boolean):void
		{
			_isValidate=boo;
		}

		/**
		 * 将组件移动到其父项内的指定位置
		 */
		public function move(x:Number, y:Number):void
		{
			if (this.x != x || this.y != y)
			{
				_changed=true;
				this.x=x;
				this.y=y;
			}
			validate();
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
		 *外观是否有改变
		 */
		public function get changed():Boolean
		{
			return _changed;
		}

		protected function onRender(e:Event):void
		{
			Debugger.debug(e, this);
			validateNow(e);
		}

		protected function onAdded(e:Event):void
		{
			Debugger.debug(e, this);
			validateNow(e);
		}

		protected function onAddedToStage(e:Event):void
		{
			Debugger.debug(e, this);
		}

		protected function onRemoved(e:Event=null):void
		{
			Debugger.debug(e, this);
		}

		protected function onRemovedFromStage(e:Event):void
		{
			Debugger.debug(e, this);
		}

		protected function onResize(e:Event):void
		{
			Debugger.debug(e, this);
		}
	}
}