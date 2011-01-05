package org.feather.lib.core
{
	import flash.events.Event;

	public interface IShapeComponent
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
		 *获取或设置组件是否支持实时渲染
		 */
		function get isValidate():Boolean
		function set isValidate(boo:Boolean):void
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
		 *外观是否有改变
		 */
		function get changed():Boolean;
		/**
		 * 将组件移动到其父项内的指定位置
		 */
		function move(x:Number, y:Number):void
	}
}