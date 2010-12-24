package org.feather.lib.event
{
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;

	/**
	 * 自定义鼠标事件，可自定义更多官方未指定的事件，并携带数据
	 * @author Aaron Wei
	 * @email weilong1@staff.sina.com.cn
	 * @msn asianfalcon@msn.com
	 * @qq 120020062
	 * @copy Copyright © 1996 - 2012 SINA Corporation, All Rights Reserved
	 */
	public class ExtMouseEvent extends MouseEvent
	{

		private var _data:Object;

		public function ExtMouseEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=false, localX:Number=0, localY:Number=0, relatedObject:InteractiveObject=null, ctrlKey:Boolean=false, altKey:Boolean=false, shiftKey:Boolean=false, buttonDown:Boolean=false, delta:int=0)
		{
			//TODO: implement function
			super(type, bubbles, cancelable, localX, localY, relatedObject, ctrlKey, altKey, shiftKey, buttonDown, delta);
		}

		public function get data():Object
		{
			return _data;
		}

		public function set data(d:Object):void
		{
			_data=d;
		}
	}
}