package org.feather.utils.events
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import org.feather.utils.Debugger;

	/**
	 * 自定义事件，可自定义更多官方未指定的事件，并携带数据
	 * @author Aaron Wei
	 * @email weilong1@staff.sina.com.cn
	 * @msn asianfalcon@msn.com
	 * @qq 120020062
	 * @copy Copyright © 1996 - 2012 SINA Corporation, All Rights Reserved
	 */
	public class ExtEventDispatcher extends EventDispatcher implements IEventDispatcher
	{
		public function ExtEventDispatcher(target:IEventDispatcher=null)
		{
			super(target);
		}

		public function dispatch(e:*, d:Object):Boolean
		{
			Debugger.debug(e, this);
			e?e.data=d:null;
			return dispatchEvent(e);
		}
	}
}