package org.feather.utils.net
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.system.LoaderContext;
	import flash.utils.clearTimeout;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	import org.feather.utils.Debugger;

	/**
	 *  显示对象加载类
	 * @author Aaron Wei
	 * @email weilong1@staff.sina.com.cn
	 * @msn asianfalcon@msn.com
	 * @qq 120020062
	 * @copy Copyright © 1996 - 2012 SINA Corporation, All Rights Reserved
	 */
	public class ProLoader
	{
		private var _loader:Loader;
		private var _limitTime:Number; //时限，单位：毫秒
		private var _handlerFun:Function; //返回结果处理函数
		private var _spendTime:Number; //过程总耗时
		private var _timeoutNum:uint; //延时变量
		private var _feedbackBoo:Boolean; //时限内是否有返回数据

		public function ProLoader():void
		{
			_feedbackBoo=false;
		}

		/**
		 * 加载器函数
		 * @param url：源；
		 * @param handler：回调函数；
		 * @param time：时限；
		 * @param context：加载器内容
		 */
		public function load(url:String, handler:Function, time:Number=NaN, context:LoaderContext=null):void
		{
			_limitTime=time;
			_handlerFun=handler;
			_loader=new Loader();
			addEventListeners(_loader.contentLoaderInfo);
			try
			{
				_loader.load(new URLRequest(url), context);
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
			try
			{
				if (_loader)
				{
					_feedbackBoo ? removeEventListeners(_loader.contentLoaderInfo) : null
					_loader.close();
				}
			}
			catch (e:*)
			{
				Debugger.debug("close:error=" + e, this);
			}
		}

		public function unload():void
		{
			if (_loader != null)
			{
				_loader.unload();
			}
		}

		private function addEventListeners(dispatcher:IEventDispatcher):void
		{
			dispatcher.addEventListener(Event.OPEN, openHandler);
			dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.addEventListener(Event.INIT, initHandler);
			dispatcher.addEventListener(Event.COMPLETE, completeHandler);
			dispatcher.addEventListener(Event.UNLOAD, unloadHandler);
			dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
			dispatcher.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
		}

		private function removeEventListeners(dispatcher:IEventDispatcher):void
		{
			try
			{
				dispatcher.removeEventListener(Event.OPEN, openHandler);
				dispatcher.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
				dispatcher.removeEventListener(Event.INIT, initHandler);
				dispatcher.removeEventListener(Event.COMPLETE, completeHandler);
				dispatcher.removeEventListener(Event.UNLOAD, unloadHandler);
				dispatcher.removeEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler);
				dispatcher.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			}
			catch (e:*)
			{
				Debugger.debug("removeEventListener:error=" + e, this);
			}
		}

		/**
		 * 规定时间内服务器未返回，视为超时
		 */
		private function checkTimeout():void
		{
			if (!_feedbackBoo)
			{
				removeEventListeners(_loader.contentLoaderInfo);
				_spendTime=getTimer() - _spendTime;
				if (_handlerFun != null)
					try
					{
						_handlerFun({target: _loader.contentLoaderInfo, info: "timeout", data: null, content: null, spendTime: _spendTime})
					}
					catch (e:*)
					{
						Debugger.debug("checkTimeout:error=" + e, this);
					}
			}
		}

		/**
		 * 下载操作开始时由关联的 LoaderInfo 对象调度
		 * @param e
		 */
		private function openHandler(e:Event):void
		{
		}

		/**
		 * 文件下载完成后由关联的 LoaderInfo 对象调度, complete 事件总是在 init 事件之后调度
		 * @param e
		 */
		private function completeHandler(e:Event):void
		{
			removeEventListeners(_loader.contentLoaderInfo);
			_feedbackBoo=true;
			clearTimeout(_timeoutNum);
			_spendTime=getTimer() - _spendTime;
			//回调函数
			try
			{
				_handlerFun({target: e.target, info: "success", data: e.currentTarget.loader, content: e.currentTarget.content, spendTime: _spendTime});
			}
			catch (e:*)
			{
				Debugger.debug("completeHandler:error=" + e, this);
			}
		}

		/**
		 * 在发生会导致加载操作失败的输入或输出错误时，由关联的 LoaderInfo 对象调度
		 * @param e
		 */
		private function ioErrorHandler(e:Event):void
		{
			removeEventListeners(_loader.contentLoaderInfo);
			_feedbackBoo=true;
			clearTimeout(_timeoutNum);
			_spendTime=getTimer() - _spendTime;
			//回调函数
			try
			{
				_handlerFun({target: e.target, info: "ioError", data: null, content: null, spendTime: _spendTime});
			}
			catch (e:*)
			{
				Debugger.debug("ioErrorHandler:error=" + e, this);
			}
		}

		/**
		 * 在可以访问被加载的 SWF 文件的属性和方法时，由关联的 LoaderInfo 对象调度。 init 事件总是在 complete 事件之前调度
		 * @param e
		 */
		private function initHandler(e:Event):void
		{
		}

		/**
		 *删除被下载的对象时，由关联的 LoaderInfo 对象调度
		 * @param e
		 */
		private function unloadHandler(e:Event):void
		{
		}

		/**
		 * 在下载操作进行过程中接收到数据时，由关联的 LoaderInfo 对象调度
		 * @param e
		 */
		private function progressHandler(e:Event):void
		{
		}

		/**
		 * 在通过 HTTP 发出网络请求并且 Flash Player 可以检测到 HTTP 状态代码时，由关联的 LoaderInfo 对象调度
		 * @param e
		 */
		private function httpStatusHandler(e:Event):void
		{
		}

		/**
		 *获取下载完成耗时
		 * @return
		 */
		public function get spendTime():Number
		{
			return _spendTime;
		}

		/**
		 *下载时限
		 * @return
		 */
		public function get limitTime():Number
		{
			return _limitTime;
		}
	}
}