package org.feather.utils.system
{
	import flash.net.LocalConnection;
	import flash.net.SharedObject;
	import flash.system.System;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;

	/**
	 *  GC强制回收，不建议使用
	 * @author Aaron Wei
	 * @email weilong1@staff.sina.com.cn
	 * @msn asianfalcon@msn.com
	 * @qq 120020062
	 * @copy Copyright © 1996 - 2012 SINA Corporation, All Rights Reserved
	 */
	public class GC
	{
		public static function GC():void
		{
			try
			{
				new LocalConnection().connect('foo');
				new LocalConnection().connect('foo');
			}
			catch (e:*)
			{
			}
		}

		public static function clear(isTraceTM:Boolean=false):void
		{
			var time:int = 2;
			var interval:int = setInterval(loop, 50);
			function loop():void
			{
				try
				{
					if (!(time--))
					{
						isTraceTM && trace(System.totalMemory);
						clearInterval(interval);
						return;
					}
					SharedObject.getLocal("cypl", "/");
				}
				catch (e:*)
				{
				}
			}
		}
	}
}



