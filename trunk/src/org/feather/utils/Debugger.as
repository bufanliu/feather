package org.feather.utils
{
	import com.hexagonstar.util.debug.Debug;
	import org.arthropod.Arthropod;

	import flash.external.ExternalInterface;
	import flash.utils.getQualifiedClassName;

	import org.feather.config.Config;

	/**
	 *  调试信息类
	 * @author Aaron Wei
	 * @email weilong1@staff.sina.com.cn
	 * @msn asianfalcon@msn.com
	 * @qq 120020062
	 * @copy Copyright © 1996 - 2012 SINA Corporation, All Rights Reserved
	 */
	public class Debugger
	{
		/**
		 * debug是否可用
		 */
		public static var DEBUG_AVAILABLE:Boolean=true;
		/**
		 * js alert弹出式debug是否可用
		 */
		public static var DEBUG_ALERT_AVAILABLE:Boolean=false;
		/**
		 * Firebug调试窗口debug是否可用
		 */
		public static var DEBUG_FIREBUGLOG_AVAILABLE:Boolean=true;
		/**
		 * Alcon调试是否可用
		 */
		public static var DEBUG_ALCON_AVAILABLE:Boolean=true;
		/**
		 * trace是否可用
		 */
		public static var DEBUG_TRACE_AVAILABLE:Boolean=true;
		/**
		 * Arthropod是否可用
		 */
		public static var DEBUG_ARTHROPOD:Boolean=true;

		public static function debug(msg:Object, instance:Object=null):void
		{
			if (DEBUG_AVAILABLE)
			{
				tracer(msg, instance);
				firebugLog(msg, instance);
				alcon(msg, instance);
				arthropod(msg, instance);
			}
		}

		public static function alert(msg:Object, instance:Object=null):void
		{
			if (DEBUG_ALERT_AVAILABLE)
			{
				try
				{
					if (ExternalInterface.available)
					{
						instance ? ExternalInterface.call("alert", getQualifiedClassName(instance) + "=======>" + msg) : ExternalInterface.call("alert", msg);
					}
					else
					{
						trace("Debugger.alert:ExternalInterface.available=false")
						alcon("Debugger.alert:ExternalInterface.available=false")
					}
				}
				catch (e:*)
				{
					trace("Debugger.alert:error=" + e)
					alcon("Debugger.alert:error=" + e)
				}
			}
		}

		public static function firebugLog(msg:Object, instance:Object=null):void
		{
			if (DEBUG_FIREBUGLOG_AVAILABLE)
			{
				try
				{
					if (ExternalInterface.available)
					{
						instance ? ExternalInterface.call("console.log", getQualifiedClassName(instance) + "=======>" + msg) : ExternalInterface.call("console.log", msg);
					}
					else
					{
						trace("Debugger.firebugLog:ExternalInterface.available=false");
						alcon("Debugger.firebugLog:ExternalInterface.available=false");
					}
				}
				catch (e:*)
				{
					trace("Debugger.firebugLog:error=" + e);
					alcon("Debugger.firebugLog:error=" + e);
				}
			}
		}

		public static function alcon(msg:Object, instance:Object=null):void
		{
			if (DEBUG_ALCON_AVAILABLE)
			{
				try
				{
					Debug.mark(0x666666);
					instance ? Debug.trace(getQualifiedClassName(instance) + "=======>" + msg) : Debug.trace(msg);
				}
				catch (e:*)
				{
					trace("Debugger.alcon:error=" + e);
				}
			}
		}

		public static function arthropod(msg:Object, instance:Object):void
		{
			if (DEBUG_ARTHROPOD)
			{
				try
				{
					instance ? Arthropod.log(getQualifiedClassName(instance) + "=======>" + msg) : Arthropod.log(msg);
				}
				catch (e:*)
				{
					trace("Debugger.arthropod:error=" + e);
				}
			}
		}

		public static function tracer(msg:Object, instance:Object=null):void
		{
			if (DEBUG_TRACE_AVAILABLE)
			{
				instance ? trace(getQualifiedClassName(instance) + "=======>" + msg) : trace(msg);
			}
		}
	}
}