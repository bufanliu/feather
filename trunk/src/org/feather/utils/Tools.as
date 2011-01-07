package org.feather.utils
{
	import flash.display.LineScaleMode;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.net.LocalConnection;
	import flash.system.Capabilities;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	/**
	 *  常用基础工具类
	 * @author Aaron Wei
	 * @email weilong1@staff.sina.com.cn
	 * @msn asianfalcon@msn.com
	 * @qq 120020062
	 * @copy Copyright © 1996 - 2012 SINA Corporation, All Rights Reserved
	 */
	public class Tools
	{

		/**
		 *生成数字文本；
		 * @param num：目标数字；
		 * @return：生成的文本；
		 */
		public static function setupNumber(num:Number):TextField
		{
			var myTextField:TextField=new TextField();
			myTextField.text="" + num;
			return myTextField;
		}

		/**
		 *生成X坐标系；
		 * @param obj：显示对象；
		 * @param origin：坐标系原点；
		 * @param length：X轴长度；
		 * @param scaleMin：最小刻度；
		 * @param scaleMid：中间刻度；
		 * @param scaleMax：最大刻度；
		 * @throws Error：参数不合理；
		 */
		public static function setupCoordinateX(obj:*, origin:Point, length:Number, scaleMin:Number, scaleMid:Number, scaleMax:Number):void
		{
			if (length > 0 && (scaleMax % scaleMin == 0))
			{
				var startPoint:Point=new Point(origin.x, origin.y);
				var endPoint:Point=new Point(origin.x + length, origin.y);
				Drawer.drawLine(obj, startPoint, endPoint, 2, 0xFFFFFF, 1);
				for (var i:int=origin.x; i < origin.x + length + scaleMin; i+=scaleMin)
				{
					if (i % scaleMax == 0)
					{
						if (i != 0)
						{
							var myText:TextField=new TextField();
							myText.autoSize=TextFieldAutoSize.LEFT;
							//myText.background=true;
							//myText.backgroundColor=0xFF3300;
							myText.textColor=0xFFFFFF;
							myText.text=String(i);
							myText.x=i - myText.width / 2;
							myText.y=15;
							var myTextFormat:TextFormat=new TextFormat();
							myTextFormat.font="微软雅黑";
							myTextFormat.size=10;
							myTextFormat.bold=true;
							myText.defaultTextFormat=myTextFormat;
							obj.addChild(myText);
							Drawer.drawLine(obj, new Point(i, origin.y), new Point(i, origin.y + 10), 2, 0xFFFFFF, 1);
						}
					}
					else if (i % scaleMid == 0)
					{
						Drawer.drawLine(obj, new Point(i, origin.y), new Point(i, origin.y + 10), 1, 0xFFFFFF, 1);
					}
					else
					{
						Drawer.drawLine(obj, new Point(i, origin.y), new Point(i, origin.y + 5), 1, 0xFFFFFF, 1);
					}
				}
			}
			else
			{
				throw new Error("Tool.setupCoordinateX:参数不正确！");
			}
		}

		/**
		 *生成Y坐标系；
		 * @param obj：显示对象；
		 * @param origin：坐标系原点；
		 * @param length：Y轴长度；
		 * @param scaleMin：最小刻度；
		 * @param scaleMid：中间刻度；
		 * @param scaleMax：最大刻度；
		 * @throws Error：参数不合理；
		 */
		public static function setupCoordinateY(obj:*, origin:Point, length:Number, scaleMin:Number, scaleMid:Number, scaleMax:Number):void
		{
			if (length > 0 && (scaleMax % scaleMin == 0))
			{
				var startPoint:Point=new Point(origin.x, origin.y);
				var endPoint:Point=new Point(origin.x, origin.y + length);
				Drawer.drawLine(obj, startPoint, endPoint, 2, 0xFFFFFF, 1);
				for (var i:int=origin.y; i < origin.y + length + scaleMin; i+=scaleMin)
				{
					if (i % scaleMax == 0)
					{
						if (i != 0)
						{
							var myText:TextField=new TextField();
							myText.autoSize=TextFieldAutoSize.LEFT;
							//myText.background=true;
							//myText.backgroundColor=0xFF3300;
							myText.textColor=0xFFFFFF;
							myText.text=String(i);
							myText.x=origin.x + 15;
							myText.y=i - myText.height / 2;
							var myTextFormat:TextFormat=new TextFormat();
							myTextFormat.font="微软雅黑";
							myTextFormat.size=10;
							myTextFormat.bold=true;
							myText.defaultTextFormat=myTextFormat;
							obj.addChild(myText);
							Drawer.drawLine(obj, new Point(i, origin.y), new Point(i, origin.y + 10), 2, 0xFFFFFF, 1);
						}
						Drawer.drawLine(obj, new Point(origin.x, i), new Point(origin.x + 10, i), 2, 0xFFFFFF, 1);
					}
					else if (i % scaleMid == 0)
					{
						Drawer.drawLine(obj, new Point(origin.x, i), new Point(origin.x + 10, i), 1, 0xFFFFFF, 1);
					}
					else
					{
						Drawer.drawLine(obj, new Point(origin.x, i), new Point(origin.x + 5, i), 1, 0xFFFFFF, 1);
					}
				}
			}
			else
			{
				throw new Error("Tool.setupCoordinateX:参数不正确！");
			}
		}

		/**
		 * 截取一定长度的字符串
		 * @param str：需被截取的字符串；
		 * @param start：起始位置；
		 * @param len：截取长度；
		 */
		static public function substr(str:String, start:int, len:int, tail:String):String
		{
			if (str.length > len)
			{
				str=str.substr(start, len) + tail;
			}
			return str;
		}

		/**
		 * 删除字符串中的所有空格符
		 * @param str
		 */
		static public function deleteBlank(str:String):void
		{
		}

		/**
		 * 比较系统当前flashplayer版本是否满足软件运行最低版本；
		 * @param targ：目标版本；
		 * @return 结果为true则通过，满足最低运行版本，反之依然；
		 */
		static public function matchLowestVersion(targ:String):Boolean
		{
			var targ_arr:Array=targ.split(",");
			var ver:String=Capabilities.version;
			var ver_arr:Array=ver.split(",");
			var ver_length:int=ver_arr.length;
			var result:Boolean=true;
			for (var i:int=1; i < ver_length; i++)
			{
				if (Number(ver_arr[i]) < Number(targ_arr[i - 1]))
				{
					result=false;
					break;
				}
			}
			return result;
		}
	}
}