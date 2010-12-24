package org.feather.config
{

	/**
	 *  sina包全局配置类
	 * @author Aaron Wei
	 * @email weilong1@staff.sina.com.cn
	 * @msn asianfalcon@msn.com
	 * @qq 120020062
	 * @copy Copyright © 1996 - 2012 SINA Corporation, All Rights Reserved
	 */
	public class Config
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
		 * 支持flash player的最低版本
		 */
		public static var DEFAULT_LOWEST_VERSION:String="9.0.124.0";
		public static const MINI_MODE:String="miniMode";
		public static const NORMAL_MODE:String="normalMode";
		public static const SIMPLE_MODE:String="simpleMode";
		public static var MODE:String;
		public static var cycleplay:Boolean=true;
	}
}

