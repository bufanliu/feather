package org.feather.utils.display
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;

	import org.feather.utils.Debugger;

	/**
	 * 布局类
	 * @author Aaron Wei
	 * @email weilong1@staff.sina.com.cn
	 * @msn asianfalcon@msn.com
	 * @qq 120020062
	 * @copy Copyright © 1996 - 2012 SINA Corporation, All Rights Reserved
	 */
	public class Layout
	{
		/**
		 *显示对象在父容器内等比缩放
		 * @param target：显示对象；
		 * @param container：父容器；
		 */
		public static function prorataOO(target:DisplayObject, container:DisplayObjectContainer):void
		{
			var targetRate:Number=target.width / target.height;
			var containerRate:Number=container.width / container.height;
			if (targetRate > containerRate)
			{
				//以容器宽为准
				target.width=container.width;
				target.height=target.width / targetRate;
			}
			else if (targetRate < containerRate)
			{
				//以容器高为准
				target.height=container.height;
				target.width=target.height * targetRate;
			}
			else if (targetRate == containerRate)
			{
				//正好填充满容器
				target.width=container.width;
				target.height=container.height;
			}

		}

		/**
		 *显示对象按宽高数值等比缩放
		 * @param target：显示对象；
		 * @param containerW：参照宽度；
		 * @param containerH：参照高度；
		 */
		public static function prorataOV(target:DisplayObject, containerW:Number, containerH:Number):void
		{
			var targetRate:Number=target.width / target.height;
			var containerRate:Number=containerW / containerH;
			if (targetRate > containerRate)
			{
				//以容器宽为准
				target.width=containerW;
				target.height=target.width / targetRate;
			}
			else if (targetRate < containerRate)
			{
				//以容器高为准
				target.height=containerH;
				target.width=target.height * targetRate;
			}
			else if (targetRate == containerRate)
			{
				//正好填充满容器
				target.width=containerW;
				target.height=containerH;
			}
		}

		/**
		 *目标宽高值容器约束等比运算
		 * @param targetW：目标宽；
		 * @param targetH：目标高；
		 * @param container：参照容器；
		 */
		public static function prorataVO(targetW:Number, targetH:Number, container:DisplayObjectContainer):Object
		{
			var obj:Object=new Object();
			var targetRate:Number=targetW / targetH;
			var containerRate:Number=container.width / container.height;
			if (targetRate > containerRate)
			{
				//以容器宽为准
				obj.width=container.width;
				obj.height=obj.width / targetRate;
			}
			else if (targetRate < containerRate)
			{
				//以容器高为准
				obj.height=container.height;
				obj.width=obj.height * targetRate;
			}
			else if (targetRate == containerRate)
			{
				//正好填充满容器
				obj.width=container.width;
				obj.height=container.height;
			}
			return obj;
		}

		/**
		 *目标宽高值按宽高数值等比缩放
		 * @param targetW：目标宽；
		 * @param targetH：目标高；
		 * @param containerW：参照宽度；
		 * @param containerH：参照高度；
		 */
		public static function prorataVV(targetW:Number, targetH:Number, containerW:Number, containerH:Number):Object
		{
			var obj:Object=new Object();
			var targetRate:Number=targetW / targetH;
			var containerRate:Number=containerW / containerH;
			if (targetRate > containerRate)
			{
				//以容器宽为准
				obj.width=containerW;
				obj.height=obj.width / targetRate;
			}
			else if (targetRate < containerRate)
			{
				//以容器高为准
				obj.height=containerH;
				obj.width=obj.height * targetRate;
			}
			else if (targetRate == containerRate)
			{
				//正好填充满容器
				obj.width=containerW;
				obj.height=containerH;
			}
			return obj;
		}

		/**
		 * 显示对象在父容器内居中
		 * @param target：显示对象；
		 * @param container：父容器；
		 */
		public static function setCenterOO(target:DisplayObject, container:DisplayObjectContainer):void
		{
			if (target && container)
			{
				container.contains(target) ? null : container.addChild(target);
				if (container is Stage)
				{
					target.x=((container as Stage).stageWidth - target.width) / 2;
					target.y=((container as Stage).stageHeight - target.height) / 2;
				}
				else
				{
					target.x=(container.width - target.width) / 2;
					target.y=(container.height - target.height) / 2;
				}
			}
		}

		/**
		 * 显示对象按宽高数值居中
		 * @param target：显示对象；
		 * @param containerW：参照宽度；
		 * @param containerH：参照高度；
		 */
		public static function setCenterOV(target:DisplayObject, containerW:Number, containerH:Number):void
		{
			target.x=(containerW - target.width) / 2;
			target.y=(containerH - target.height) / 2;
		}

		/**
		 * 显示对象在父容器内置顶
		 * @param target：显示对象；
		 * @param container：父容器；
		 */
		public static function setTopOO(target:DisplayObject, container:DisplayObjectContainer):void
		{
			container.addChild(target);
			target.y=0; //未完。。。
		}

		/**
		 * 显示对象参照宽高值置顶
		 * @param target：显示对象；
		 * @param containerW： 参照宽度；
		 * @param containerH：参照高度；
		 */
		public static function setTopOV(target:DisplayObject, containerW:Number, containerH:Number):void
		{
			target.y=0;
		}

		/**
		 * 显示对象在父容器内置底部
		 * @param target：显示对象；
		 * @param container：父容器；
		 */
		public static function setBottomOO(target:DisplayObject, container:DisplayObjectContainer):void
		{
			container.addChild(target);
			target.y=container.height - target.height; //未完。。。
		}

		/**
		 * 显示对象参照宽高值置底
		 * @param target：显示对象；
		 * @param containerW： 参照宽度；
		 * @param containerH：参照高度；
		 */
		public static function setBottomOV(target:DisplayObject, containerW:Number, containerH:Number):void
		{
			target.y=containerH - target.height;
		}

		/**
		 * 显示对象在父容器内置左
		 * @param target：显示对象；
		 * @param container：父容器；
		 */
		public static function setLeftOO(target:DisplayObject, container:DisplayObjectContainer):void
		{
			container.addChild(target);
			target.x=0; //未完。。。
		}

		/**
		 * 显示对象参照宽高值置左
		 * @param target：显示对象；
		 * @param containerW： 参照宽度；
		 * @param containerH：参照高度；
		 */
		public static function setLeftOV(target:DisplayObject, containerW:Number, containerH:Number):void
		{
			target.x=0;
		}

		/**
		 * 显示对象在父容器内置右
		 * @param target：显示对象；
		 * @param container：父容器；
		 */
		public static function setRightOO(target:DisplayObject, container:DisplayObjectContainer):void
		{
			container.addChild(target);
			target.x=container.width - target.width; //未完。。。
		}

		/**
		 * 显示对象参照宽高值置右
		 * @param target：显示对象；
		 * @param containerW： 参照宽度；
		 * @param containerH：参照高度；
		 */
		public static function setRightOV(target:DisplayObject, containerW:Number, containerH:Number):void
		{
			target.x=containerW - target.width;
		}

		/**
		 * 显示对象在父容器内置左上
		 * @param target：显示对象；
		 * @param container：父容器；
		 */
		public static function setLeftTopOO(target:DisplayObject, container:DisplayObjectContainer):void
		{
			setLeftOO(target, container);
			setTopOO(target, container);
		}

		/**
		 * 显示对象参照宽高值置左上
		 * @param target：显示对象；
		 * @param containerW： 参照宽度；
		 * @param containerH：参照高度；
		 */
		public static function setLeftTopOV(target:DisplayObject, containerW:Number, containerH:Number):void
		{
			setLeftOV(target, containerW, containerH);
			setTopOV(target, containerW, containerH);
		}

		/**
		 * 显示对象在父容器内置左下
		 * @param target：显示对象；
		 * @param container：父容器；
		 */
		public static function setLeftBottomOO(target:DisplayObject, container:DisplayObjectContainer):void
		{
			setLeftOO(target, container);
			setBottomOO(target, container);
		}

		/**
		 * 显示对象参照宽高值置左下
		 * @param target：显示对象；
		 * @param containerW： 参照宽度；
		 * @param containerH：参照高度；
		 */
		public static function setLeftBottomOV(target:DisplayObject, containerW:Number, containerH:Number):void
		{
			setLeftOV(target, containerW, containerH);
			setBottomOV(target, containerW, containerH);
		}

		/**
		 * 显示对象在父容器内置右上
		 * @param target：显示对象；
		 * @param container：父容器；
		 */
		public static function setRightTopOO(target:DisplayObject, container:DisplayObjectContainer):void
		{
			setRightOO(target, container);
			setTopOO(target, container);
		}

		/**
		 * 显示对象参照宽高值置右上
		 * @param target：显示对象；
		 * @param containerW： 参照宽度；
		 * @param containerH：参照高度；
		 */
		public static function setRightTopOV(target:DisplayObject, containerW:Number, containerH:Number):void
		{
			setRightOV(target, containerW, containerH);
			setTopOV(target, containerW, containerH);
		}

		/**
		 * 显示对象在父容器内置右下
		 * @param target：显示对象；
		 * @param container：父容器；
		 */
		public static function setRightBottomOO(target:DisplayObject, container:DisplayObjectContainer):void
		{
			setRightOO(target, container);
			setBottomOO(target, container);
		}

		/**
		 * 显示对象参照宽高值置右下
		 * @param target：显示对象；
		 * @param containerW： 参照宽度；
		 * @param containerH：参照高度；
		 */
		public static function setRightBottomOV(target:DisplayObject, containerW:Number, containerH:Number):void
		{
			setRightOV(target, containerW, containerH);
			setBottomOV(target, containerW, containerH);
		}
	}
}