package org.feather.utils.display
{
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.utils.clearInterval;
	import flash.utils.setInterval;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getQualifiedSuperclassName;

	import org.feather.utils.Debugger;
	import org.feather.utils.Tools;

	public class StageSetting
	{
		private static var _stage:Stage;
		private static var _setInterval:Number;
		private static var _callbackFun:Function;

		public static function check(callback:Function, s:Stage):void
		{
			_callbackFun=(callback != null) ? callback : _callbackFun;
			_stage=s ? s : _stage;
			_setInterval=setInterval(function():void
				{
					if (_stage && _stage.stageWidth > 0 && _stage.stageHeight > 0)
					{
						clearInterval(_setInterval);
						callback();
					}
					else
					{
						throw new Error("StageSetting.checkIn:stage对象为null");
					}
				}, 10);
		}

		private static function set scaleMode(mode:String):void
		{
			if (_stage)
			{
				_stage.scaleMode=mode;
			}
			else
			{
				throw new Error("StageSetting.scaleMode:stage对象为null");
			}
		}

		private static function get scaleMode():String
		{
			if (_stage)
			{
				return _stage.scaleMode;
			}
			else
			{
				throw new Error("StageSetting.scaleMode:stage对象为null");
				return null;
			}
		}

		private static function set align(quality:String):void
		{
			if (_stage)
			{
				_stage.quality=quality;
			}
			else
			{
				throw new Error("StageSetting.align:stage对象为null");
			}
		}

		private static function get quality():String
		{
			if (_stage)
			{
				return _stage.quality;
			}
			else
			{
				throw new Error("StageSetting.align:stage对象为null");
				return null
			}
		}

		private static function set tabChildren(tab:Boolean):void
		{
			if (_stage)
			{
				_stage.tabChildren=tab;
			}
			else
			{
				throw new Error("StageSetting.align:stage对象为null");
			}
		}

		private static function get tabChildren():Boolean
		{
			if (_stage)
			{
				return _stage.tabChildren;
			}
			else
			{
				throw new Error("StageSetting.align:stage对象为null");
				return null;
			}
		}

		public static function get stage():Stage
		{
			return _stage;
		}

		public static function set stage(s:Stage):void
		{
			_stage=s as Stage;
		}
	}
}