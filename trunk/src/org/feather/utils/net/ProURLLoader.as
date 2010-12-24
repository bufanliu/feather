package org.feather.utils.net
{
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.clearTimeout;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;

	import org.feather.utils.Debugger;

	/**
	 *  数据加载类
	 * @author Aaron Wei
	 * @email weilong1@staff.sina.com.cn
	 * @msn asianfalcon@msn.com
	 * @qq 120020062
	 * @copy Copyright © 1996 - 2012 SINA Corporation, All Rights Reserved
	 */
	public class ProURLLoader
	{
		private var _URLLoader:URLLoader;
		private var _URLRequest:URLRequest;
		private var _limitTime:Number; //时限，单位：毫秒
		private var _handlerFun:Function; //返回结果处理函数
		private var _spendTime:Number; //过程总耗时
		private var _timeoutNum:Number; //延时变量
		private var _feedbackBoo:Boolean; //时限内是否有返回数据

		public function ProURLLoader():void
		{
			_feedbackBoo=false;
		}

		/**
		 *加载函数
		 * @param url：源；
		 * @param handler：回调；
		 * @param time：时限；
		 * @param method：方式；
		 * @param dataFormat：数据格式；
		 * @param headers：头文件；
		 */
		public function load(url:String, handler:Function, time:Number=NaN, method:Object=null, dataFormat:String="null", headers:Array=null):void
		{
			_limitTime=time;
			_handlerFun=handler;
			_URLLoader=new URLLoader();
			switch (dataFormat)
			{
				case "text":
				case "null":
					_URLLoader.dataFormat=URLLoaderDataFormat.TEXT;
					break;
				case "binary":
					_URLLoader.dataFormat=URLLoaderDataFormat.BINARY;
					break;
				case "var":
					_URLLoader.dataFormat=URLLoaderDataFormat.VARIABLES;
					break;
			}
			addEventListeners(_URLLoader);
			_URLRequest=new URLRequest(url);
			if (method != null)
			{
				_URLRequest.method=method.method == "POST" ? URLRequestMethod.POST : URLRequestMethod.GET;
				switch (method.dataType)
				{
					case "u":
						var variables:URLVariables=new URLVariables();
						for (var k:*in method.data)
						{
							variables[k]=method.data[k];
						}
						_URLRequest.data=variables;
						break;
					case "b":
						_URLRequest.data=method.data;
						break;
				}
			}
			if (headers != null)
			{
				for (var i:uint=0; i < headers.length; i++)
				{
					_URLRequest.requestHeaders.push(new URLRequestHeader(String(headers[i].name), String(headers[i].value)));
				}
			}

			try
			{
				_URLLoader.load(_URLRequest);
				_URLRequest.data=null; //非常非常重要的一个步骤，大文件上传时GC，缺省此行将内存泄露
				if (method)
				{
					method.data=null;
				}
			}
			catch (e:*)
			{
				Debugger.debug("load:error=" + e, this);
			}
			if (!isNaN(_limitTime))
			{
				_timeoutNum=setTimeout(checkTimeout, _limitTime);
			}
			_spendTime=getTimer();
		}

		public function close():void
		{
			if (_URLLoader != null)
			{
				_URLLoader.close();
			}
		}

		private function addEventListeners(dispatcher:IEventDispatcher):void
		{
			dispatcher.addEventListener(Event.OPEN, openHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.addEventListener(Event.COMPLETE, completeHandler);
			dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}

		private function removeEventListeners(dispatcher:IEventDispatcher):void
		{
			dispatcher.removeEventListener(Event.OPEN, openHandler);
			dispatcher.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.removeEventListener(Event.COMPLETE, completeHandler);
			dispatcher.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			dispatcher.removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			dispatcher.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}

		private function checkTimeout():void
		{
			if (!_feedbackBoo)
			{
				//规定时间内服务器未返回，视为超时
				removeEventListeners(_URLLoader);
				_spendTime=getTimer() - _spendTime;
				if (_handlerFun != null)
					_handlerFun({currentTarget: this, target: _URLLoader, info: "timeout", data: null, spendTime: _spendTime})
			}
		}

		private function openHandler(e:Event):void
		{
			//在加载操作开始时调度
		}

		private function completeHandler(e:Event):void
		{
			//在成功加载数据后调度
			_feedbackBoo=true;
			clearTimeout(_timeoutNum);
			_spendTime=getTimer() - _spendTime;
			_handlerFun({currentTarget: this, target: e.target, info: "success", data: e.target.data, spendTime: _spendTime});
		}

		private function ioErrorHandler(e:Event):void
		{
			//无法完成加载操作
			_feedbackBoo=true;
			clearTimeout(_timeoutNum);
			_spendTime=getTimer() - _spendTime;
			_handlerFun({currentTarget: this, target: e.target, info: "ioError", data: e.target.data, spendTime: _spendTime})
		}

		private function progressHandler(e:Event):void
		{
			//在下载操作过程中收到数据时调度
		}

		private function httpStatusHandler(e:Event):void
		{
			//如果通过 HTTP 进行访问，并且当前 Flash Player 环境支持获得状态代码，则除了 complete 或 error 事件，还可以接收到 HTTPStatusEvent 事件
		}

		private function securityErrorHandler(e:SecurityErrorEvent):void
		{
			//加载操作尝试从调用方安全沙箱外部的服务器检索数据，可以通过在服务器上使用策略文件来解决此问题
		}

		/**
		 *获取过程耗时
		 * @return
		 */
		public function get spendTime():Number
		{
			return _spendTime;
		}

		/**
		 *获取时限
		 * @return
		 */
		public function get limitTime():Number
		{
			return _limitTime;
		}

	}
}