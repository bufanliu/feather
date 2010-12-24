package org.feather.utils.net
{
	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.external.ExternalInterface;
	import org.feather.utils.Debugger;

	/**
	 * 链接跳转类
	 * @author Aaron Wei
	 * @email weilong1@staff.sina.com.cn
	 * @msn asianfalcon@msn.com
	 * @qq 120020062
	 * @copy Copyright © 1996 - 2012 SINA Corporation, All Rights Reserved
	 */
	public class ProNavigateToURL
	{
		/**
		 * 打开窗口
		 * @param url：链接地址
		 * @param window：新窗口模式
		 * @param features：
		 */
		public static function openWindow(url:String, window:String="_blank", features:String=""):void
		{
			var WINDOW_OPEN_FUNCTION:String="window.open";
			var myURL:URLRequest=new URLRequest(url);
			var browserName:String=ProNavigateToURL.getBrowserName();

			if (browserName == "Firefox")
			{
				ExternalInterface.call(WINDOW_OPEN_FUNCTION, url, window, features);
			}
			else if (browserName == "IE")
			{
				ExternalInterface.call(WINDOW_OPEN_FUNCTION, url, window, features);
			}
			else if (browserName == "Safari")
			{
				navigateToURL(myURL, window);
			}
			else if (browserName == "Opera")
			{
				navigateToURL(myURL, window);
			}
			else
			{
				navigateToURL(myURL, window);
			}
		}

		/**
		 * 判断当前浏览器类型
		 * @return
		 */
		public static function getBrowserName():String
		{
			var browser:String;
			//Uses external interface to reach out to browser and grab browser useragent info.
			var browserAgent:String=ExternalInterface.call("function getBrowser(){return navigator.userAgent;}");
			//Determines brand of browser using a find index. If not found indexOf returns (-1).
			if (browserAgent != null && browserAgent.indexOf("Firefox") >= 0)
			{
				browser="Firefox";
			}
			else if (browserAgent != null && browserAgent.indexOf("Safari") >= 0)
			{
				browser="Safari";
			}
			else if (browserAgent != null && browserAgent.indexOf("MSIE") >= 0)
			{
				browser="IE";
			}
			else if (browserAgent != null && browserAgent.indexOf("Opera") >= 0)
			{
				browser="Opera";
			}
			else
			{
				browser="Undefined";
			}
			Debugger.debug("ProNavigateToURL.getBrowser:browser= " + browser);
			return browser;
		}
	}
}