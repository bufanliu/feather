package org.feather.lib.core
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;

	import org.feather.config.LayoutConfig;
	import org.feather.utils.Debugger;
	import org.feather.utils.Drawer;
	import org.feather.utils.Tools;
	import org.feather.utils.data.HashSet;
	import org.feather.utils.data.Option;

	/**
	 * 显示组件核心基类
	 * @author Aaron Wei
	 * @email weilong1@staff.sina.com.cn
	 * @msn asianfalcon@msn.com
	 * @qq 120020062
	 * @copy Copyright © 1996 - 2012 SINA Corporation, All Rights Reserved
	 */
	public class BaseUIComponent extends Sprite implements IBaseUIComponent
	{
		/** 属性对象*/
		protected var _style:Object;
		/**组件内部子集*/
		protected var _children:Array;
		/**组件内部位于显示列表的子集*/
		protected var _displayListHash:HashSet;
		/**样式属性*/
		protected var _startX:Number;
		protected var _startY:Number;
		protected var _wsize:Number;
		protected var _hsize:Number;
		protected var _stage:Stage;
		/** 组件初始化参数是否为null的标识*/
		protected var _isParamNull:Boolean;
		/**组件是否禁用*/
		protected var _enabled:Boolean;
		/**是否支持实时渲染*/
		protected var _isValidate:Boolean;
		/**组件状态是否有改变*/
		protected var _changed:Boolean;

		/**显示组件核心基类（抽象类不被实例化）*/
		public function BaseUIComponent(style:Object=null):void
		{
			super();
			_changed=true;
			_isParamNull=style ? false : true;
			_style=style || new Object();
			_children=new Array();
			_displayListHash=new HashSet();
			initialize();
		}

		/**
		 * 初始化组件数据
		 * @param info
		 */
		protected function initialize():void
		{
			commitProperties();
			creatChildren();
			registerEvents();
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
			_style.wsize=_wsize=(_style && (_style.wsize || _style.wsize === 0)) ? _style.wsize : LayoutConfig.DEFAULT_W;
			_style.hsize=_hsize=(_style && (_style.hsize || _style.hsize === 0)) ? _style.hsize : LayoutConfig.DEFAULT_H;
			_style.enabled=_enabled=(_style && _style.enabled == false) ? false : true;
			_style.isValidate=_isValidate=_style && _style.isValidate ? _style.isValidate : true;
		}

		/**所有属性归为初始化状态*/
		protected function invalidateProperties():void
		{
			_style=new Object();
			commitProperties();
		}

		/**
		 * 创建组件的子对象
		 */
		protected function creatChildren():void
		{
		}

		/**
		 * 移除组件的子对象
		 */
		protected function removeChildren():void
		{
			_displayListHash.foreach(function(k:*):void
				{
					removeChild(k)
				})
			_displayListHash.clear();
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

		/**
		 * 执行生效
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
		 * 立即执行生效
		 */
		public function validateNow(e:Event=null):void
		{
			if (((e && e.eventPhase != 3) || !e) && this.parent)
			{
				invalidate();
				draw(e);
				creatChildren();
				layout();
			}
		}

		/**
		 * 作废
		 */
		public function invalidate():void
		{
			clear();
			removeChildren();
		}

		/**
		 *渲染、绘制
		 */
		protected function draw(e:Event=null):void
		{

		}

		/**
		 *清除渲染、绘制
		 */
		protected function clear():void
		{
			Drawer.clear(this);
		}

		/**
		 * 子对象在组件内部的布局
		 */
		protected function layout():void
		{

		}

		/**
		 * <br>The purpose of this method is to perform measurement</br>
		 * <br> calculation and define sizing information for the framework.</br>
		 */
		protected function measure():void
		{
		}

		protected function invalidateSize():void
		{
		}

		public function updateDisplayList():void
		{
		}

		public function invalidateDisplayList():void
		{
		}

		/**
		 * validater是否生效
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
			if (_isValidate != boo)
			{
				_changed=true;
				_style.isValidate=_isValidate=boo;
			}
			validate();
		}

		/**
		 * 设置组件样式
		 * @param info：样式信息
		 */
		public function set style(info:Object):void
		{
			_style=info;
			commitProperties();
			validateNow();
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
		 * 组件内部子集
		 */
		public function get children():Array
		{
			return _children;
		}

		/**
		 * 组件内部位于显示列表的子集
		 */
		public function get displayList():HashSet
		{
			return _displayListHash;
		}

		/**
		 * 将组件移动到其父项内的指定位置
		 */
		public function move(x:Number, y:Number):void
		{
			if (!(this.x == x && this.y == y))
			{
				_changed=false;
				this.x=x;
				this.y=y;
			}
			validate();
		}

		/**
		 * 设置组件相对外部宽高
		 * @param w：组件相对外部宽；
		 * @param h：组件相对外部高；
		 */
		public function setSize(w:Number, h:Number):void
		{
			if (this.width !== w || this.height !== h)
			{
				_changed=true;
				this.width=w;
				this.height=h;
			}
			validate();
		}

		/**
		 * 设置组件相对内部宽高
		 * @param w：组件相对内部宽；
		 * @param h：组件相对内部高；
		 */
		public function setSelfSize(ws:Number, hs:Number):void
		{
			if (this.wsize !== ws || this.hsize !== hs)
			{
				_changed=true;
				this.wsize=ws;
				this.hsize=hs;
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
			if (_wsize !== w)
			{
				_changed=true;
				_wsize=_style.wsize=w;
			}
			validate();
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
			if (_hsize !== h)
			{
				_changed=true;
				_hsize=_style.hsize=h;
			}
			validate();
		}

		public function get enabled():Boolean
		{
			return _enabled;
		}

		public function set enabled(boo:Boolean):void
		{
			if (_enabled !== boo)
			{
				_changed=true;
				_enabled=boo;
			}
			validate();
		}

		public function get changed():Boolean
		{
			return _changed;
		}
	}
}