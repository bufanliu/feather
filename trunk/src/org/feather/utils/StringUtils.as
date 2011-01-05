package org.feather.utils
{
	import flash.utils.ByteArray;

	/**
	 * ... 字符串工具类 ...
	 * @author Jerry
	 * @version 0.4.0
	 */
	public final class StringUtil
	{
		/** ASCII 编码格式 */
		public static const ASCII:String = "us-ascii";

		/** UTF-8 编码格式 */
		public static const UTF8:String = "utf-8";

		/** UTF-16 编码格式 */
		public static const UTF16:String = "unicode";

		/** 中文简体编码格式 */
		public static const GB2312:String = "gb2312";

		/** 中文繁体编码格式 */
		public static const BIG5:String = "big5";

		/**
		 * 将时间（以毫秒为单位）以指定文本格式输出
		 * @param	time 一个数字，被转换的时间值，单位为毫秒
		 * @param	withHour 一个布尔值，指示输出的文本是否含带小时部分字符串
		 * @param	sep 一个字符串，指示时间单位的间隔符
		 * @return	时间文本字符串
		 */
		public static function getTimeStr(time:Number=0, withHour:Boolean=false, sep:String=":"):String
		{
			var hour:*;
			var min:*;
			var sec:*;
			var timeStrArr:Array;
			time/=MathUtil.MSEL_STEP;
			hour=MathUtil.floor(time / Math.pow(MathUtil.TIME_STEP, 2));
			min=MathUtil.floor(time / MathUtil.TIME_STEP) % MathUtil.TIME_STEP;
			sec=MathUtil.floor(time % MathUtil.TIME_STEP);
			if (hour < 10)
				hour="0" + String(hour);
			if (min < 10)
				min="0" + String(min);
			if (sec < 10)
				sec="0" + String(sec);
			if (withHour)
			{
				timeStrArr=[hour, min, sec];
			}
			else
			{
				timeStrArr=[min, sec];
			}
			return timeStrArr.join(sep);
		}

		/**
		 * 获取指定长度的随机字符串（只包含英文和数字）
		 * @param	length	一个整数，指示返回的随机字符串的长度
		 * @return	得到随机字符串
		 */
		public static function getRandomStr(length:int=4):String
		{
			var ran:int = 0;
			var number:int = 0;
			var code:String = "";
			var checkCode:String = "";
			for (var i:int = 0; i < length; i++)
			{
				ran=MathUtil.round(Math.random() * 2);
				number=MathUtil.round(Math.random() * 10000);
				if (ran == 0)
				{
					code=String.fromCharCode(48 + (number % 10));
				}
				else if (ran == 1)
				{
					code=String.fromCharCode(65 + (number % 26));
				}
				else
				{
					code=String.fromCharCode(97 + (number % 26));
				}
				checkCode+=code;
			}
			return checkCode;
		}

		/**
		 * 根据编码格式获取字符串的真实长度
		 * @param	source 一个字符串，字符串源
		 * @param	charSet 一个字符串，指定字符串的字符编码
		 * @return	字符串的长度
		 */
		public static function getStrLength(source:String, charSet:String=GB2312):uint
		{
			var byteArr:ByteArray = new ByteArray();
			byteArr.writeMultiByte(source, charSet);
			return byteArr.length;
		}

		/**
		 * 截取字符串（支持中文简体、繁体）
		 * @param	source 一个字符串，被截取的字符串源
		 * @param	length 一个整数，截取字符串的长度（包括后缀字符串的长度）
		 * @param	withSuffix 一个布尔值，输出的字符串是否带后缀
		 * @param	suffix 一个字符串，输出字符串后缀的内容
		 * @param	charSet 一个字符串，指定字符串的字符编码
		 * @return	截取的字符串
		 */
		public static function substr(source:String, length:int=20, withSuffix:Boolean=true, suffix:String="...", charSet:String=GB2312):String
		{
			var outStr:String = "";
			var strArr:Array = source.split("");
			var totalLen:int = 0;
			var arrLen:int = strArr.length;
			var suffixLen:int = getStrLength(suffix, charSet);
			for (var i:*in strArr)
			{
				var trueLen:int = getStrLength(strArr[i], charSet);
				totalLen+=trueLen;
				outStr+=strArr[i];
				if (totalLen >= length - suffixLen)
				{
					if (i != arrLen && withSuffix)
					{
						outStr+=suffix;
					}
					break;
				}
			}
			return outStr;
		}
	}
}