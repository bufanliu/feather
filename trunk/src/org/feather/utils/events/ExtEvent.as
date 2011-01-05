package org.feather.utils.events
{
	import flash.events.Event;
	import org.feather.utils.Debugger;

	/**
	 * 自定义事件，可自定义更多官方未指定的事件，并携带数据
	 * @author Aaron Wei
	 * @email weilong1@staff.sina.com.cn
	 * @msn asianfalcon@msn.com
	 * @qq 120020062
	 * @copy Copyright © 1996 - 2012 SINA Corporation, All Rights Reserved
	 */
	public class ExtEvent extends Event
	{	
		private var _data:Object;

		public function ExtEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			//TODO: implement function
			super(type, bubbles, cancelable);
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