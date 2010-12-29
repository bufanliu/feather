package org.feather.lib.core
{
	import flash.display.Stage;
	import flash.events.Event;

	/**
	 * 显示组件基础接口
	 * @author Aaron Wei
	 * @email weilong1@staff.sina.com.cn
	 * @msn asianfalcon@msn.com
	 * @qq 120020062
	 * @copy Copyright © 1996 - 2012 SINA Corporation, All Rights Reserved
	 */

	public interface IBaseUIComponent
	{
		/**
		 *渲染
		 */
		function validate(e:Event=null):void
		/**
		 *及时渲染
		 */
		function validateNow(e:Event=null):void
		/**
		 *废除渲染
		 */
		function invalidate():void;
		/**
		 *获取或设置组件数据
		 */
		function get style():Object;
		function set style(info:Object):void;
		function get isValidate():Boolean
		function set isValidate(boo:Boolean):void
		/**
		 * 将组件移动到其父项内的指定位置
		 */
		function move(x:Number, y:Number):void;
		/**
		 * 设置组件相对外部宽高
		 * @param w：组件相对外部宽；
		 * @param h：组件相对外部高；
		 */
		function setSize(w:Number, h:Number):void
		/**
		 * 设置组件相对内部宽高
		 * @param w：组件相对内部宽；
		 * @param h：组件相对内部高；
		 */
		function setSelfSize(ws:Number, hs:Number):void
		/**
		 *获取组件左上角顶点相对自坐标系的x坐标
		 * @return：组件左上角顶点相对自坐标系的x坐标
		 */
		function get startX():Number;
		/**
		 *获取组件左上角顶点相对自坐标系的y坐标
		 * @return：组件左上角顶点相对自坐标系的y坐标
		 */
		function get startY():Number;
		/**
		 *获取或设置组件相对内部宽
		 */
		function get wsize():Number;
		function set wsize(w:Number):void;
		/**
		 *获取或设置组件相对内部高
		 */
		function get hsize():Number;
		function set hsize(h:Number):void;
		/**
		 *获取或设置组件圆角宽
		 */
		function get rw():Number;
		function set rw(h:Number):void;
		/**
		 *获取或设置组件圆角高
		 */
		function get rh():Number;
		function set rh(h:Number):void;
		/**
		 * 获取一个值，该值指示组件是否可以接受用户交互
		 */
		function get enabled():Boolean;
		/**
		 * 获取或设置一个值，该值指示组件是否可以接受用户交互
		 * @param boo：组件是否可以接受用户交互；
		 */
		function set enabled(boo:Boolean):void;
		function get changed():Boolean;
	}
}