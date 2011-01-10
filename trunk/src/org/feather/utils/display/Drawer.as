package org.feather.utils.display
{
	import flash.display.CapsStyle;
	import flash.display.DisplayObject;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Matrix;

	import org.feather.config.LayoutConfig;
	import org.feather.lib.layout.BorderFillLayout;

	/**
	 *  几何图形绘制类
	 * @author Aaron Wei
	 * @email weilong1@staff.sina.com.cn
	 * @msn asianfalcon@msn.com
	 * @qq 120020062
	 * @copy Copyright © 1996 - 2012 SINA Corporation, All Rights Reserved
	 */

	public class Drawer
	{
		private static const DEFAULT_BG_COLOR:uint=0xEEEEEE;
		private static const DEFAULT_BG_ALP:Number=1;
		private static const DEFAULT_BORDER_COLOR:uint=0xDDDDDD;
		private static const DEFAULT_BORDER_ALP:Number=1;
		private static const DEFAULT_THICKNESS:Number=1;
		private static const DEFAULT_W:Number=320;
		private static const DEFAULT_H:Number=240;
		private static const DEFAULT_RW:Number=0;
		private static const DEFAULT_RH:Number=0;

		/**
		 * 画线段
		 * @param obj：容器；
		 * @param start：线段起点；
		 * @param end：线段终点；
		 * @param thickness：线段粗细；
		 * @param color：线段颜色；
		 * @param alpha：线段透明度；
		 * @param pixelHinting：笔触是否采用完整象素；
		 * @param scaleMode：线条缩放模式；
		 * @param caps：线头模式；
		 * @param joints：拐角的连接外观的类型；
		 * @param miterLimit：切断尖角的位置；
		 */
		public static function drawLine(obj:*, start:Point, end:Point, thickness:uint=DEFAULT_THICKNESS, color:uint=DEFAULT_BORDER_COLOR, alpha:Number=DEFAULT_BORDER_ALP, pixelHinting:Boolean=true, scaleMode:String="none", caps:String=null, joints:String=null, miterLimit:Number=3):void
		{
			obj.graphics.lineStyle(thickness, color, alpha, pixelHinting, scaleMode, caps, joints, miterLimit);
			obj.graphics.moveTo(start.x, start.y);
			obj.graphics.lineTo(end.x, end.y);
		}

		/**
		 * 画渐变线段
		 * @param obj:* — 容器
		 * @param start:Point — 线段起点
		 * @param end:Point — 线段终点
		 * @param type:String — 用于指定要使用哪种渐变类型的 GradientType 类的值：GradientType.LINEAR 或 GradientType.RADIAL
		 * @param colors:Array — 要在渐变中使用的 RGB 十六进制颜色值数组（例如，红色为 0xFF0000，蓝色为 0x0000FF 等等）
		 * @param alphas:Array — colors 数组中对应颜色的 alpha 值数组；有效值为 0 到 100。 如果值小于 0，Flash Player 将使用 0。 如果值大于 100，Flash Player 将使用 100
		 * @param  ratios:Array — 颜色分布比率的数组；有效值为 0 到 255。 该值定义 100% 采样的颜色所在位置的宽度百分比。 值 0 表示渐变框中的左侧位置，255 表示渐变框中的右侧位置。 该值表示渐变框中的位置，而不是最终渐变的坐标空间，坐标空间可能比渐变框宽或窄。 为 colors 参数中的每个值指定一个值
		 * @param thickness:uint — 线段粗细
		 * @param matrix:Matrix (default = null) — 一个由 flash.geom.Matrix 类定义的转换矩阵。 flash.geom.Matrix 类包括 createGradientBox() 方法，通过该方法可以方便地设置矩阵，以便与 lineGradientStyle() 方法一起使用
		 * @param spreadMethod:String (default = "pad") — 用于指定要使用哪种 spread 方法的 SpreadMethod 类的值
		 * @param interpolationMethod:String (default = "rgb") — 用于指定要使用哪个值的 InterpolationMethod 类的值
		 * @param focalPointRatio:Number (default = 0) — 一个控制渐变的焦点位置的数字
		 */
		public static function drawGradientLine(obj:*, start:Point, end:Point, type:String, colors:Array, alphas:Array, ratios:Array, thickness:uint=DEFAULT_THICKNESS, matrix:Matrix=null, spreadMethod:String=SpreadMethod.PAD, interpolationMethod:String="rgb", focalPointRatio:Number=0):void
		{
			obj.graphics.lineStyle(thickness);
			obj.graphics.lineGradientStyle(type, colors, alphas, ratios, matrix, spreadMethod, interpolationMethod, focalPointRatio);
			obj.graphics.moveTo(start.x, start.y);
			obj.graphics.lineTo(end.x, end.y);
		}

		/**
		 * 画连线
		 * @param obj：容器；
		 * @param points：连线的各节点；
		 * @param thickness：线段粗细；
		 * @param color：线段颜色；
		 * @param alpha：线段透明度；
		 * @param pixelHinting：笔触是否采用完整象素；
		 * @param scaleMode：线条缩放模式；
		 * @param caps：线头模式；
		 * @param joints：拐角的连接外观的类型；
		 * @param miterLimit：切断尖角的位置；
		 */
		public static function drawLines(obj:*, points:Array, thickness:uint=DEFAULT_THICKNESS, color:uint=DEFAULT_BORDER_COLOR, alpha:Number=DEFAULT_BORDER_ALP, pixelHinting:Boolean=true, scaleMode:String="none", caps:String=null, joints:String=null, miterLimit:Number=3):void
		{
			obj.graphics.lineStyle(thickness, color, alpha, pixelHinting, scaleMode, caps, joints, miterLimit);
			obj.graphics.moveTo(points[0].x, points[0].y);
			var i:int=1;
			while (i < points.length)
			{
				obj.graphics.lineTo(points[i].x, points[i].y);
				++i;
			}
		}

		/**
		 * 画矢量矩形
		 * @param obj：被绘制的Sprite载体；
		 * @param x：矩面左上角x坐标；
		 * @param y：矩面左上角y坐标；
		 * @param w：矩面宽度；
		 * @param h：矩面高度；
		 * @param bgColor：矩面颜色；
		 * @param bgAlp：矩面透明度；
		 * @param rw：圆角宽；
		 * @param rh：圆角高；
		 * @param borderColor：矩框颜色；
		 * @param borderAlp：矩框透明度；
		 * @param thickness：矩框粗细；
		 * @param mode：矩框填充模式；
		 * @param pixelHinting：笔触是否采用完整象素；
		 * @param scaleMode：线条缩放模式；
		 * @param caps：线头模式；
		 * @param joints：拐角的连接外观的类型；
		 * @param miterLimit：切断尖角的位置；
		 */
		public static function drawRect(obj:*, x:Number=0, y:Number=0, w:Number=DEFAULT_W, h:Number=DEFAULT_H, bgColor:uint=DEFAULT_BG_COLOR, bgAlp:Number=DEFAULT_BG_ALP, rw:Number=DEFAULT_RW, rh:Number=DEFAULT_RH, thickness:Number=DEFAULT_THICKNESS, borderColor:uint=DEFAULT_BORDER_COLOR, borderAlp:Number=DEFAULT_BORDER_ALP, mode:String="inner", pixelHinting:Boolean=false, scaleMode:String="none", caps:String=null, joints:String=null, miterLimit:Number=3):void
		{
			drawRectArea(obj, x, y, w, h, bgColor, bgAlp, rw, rh);
			drawRectBorder(obj, x, y, w, h, borderColor, borderAlp, thickness, rw, rh, mode, pixelHinting, scaleMode, caps, joints, miterLimit);
		}

		/**
		 * 画矢量矩面
		 * @param obj：被绘制的Sprite载体；
		 * @param x：矩面左上角x坐标；
		 * @param y：矩面左上角y坐标；
		 * @param w：矩面宽度；
		 * @param h：矩面高度；
		 * @param color：矩面颜色；
		 * @param alp：矩面透明度；
		 * @param rw：矩面圆角宽度；
		 * @param rh：矩面圆角高度；
		 */
		public static function drawRectArea(obj:*, x:Number=0, y:Number=0, w:Number=DEFAULT_W, h:Number=DEFAULT_H, color:uint=DEFAULT_BG_COLOR, alp:Number=DEFAULT_BG_ALP, rw:Number=DEFAULT_RW, rh:Number=DEFAULT_RH):void
		{
			obj.graphics.beginFill(color, alp);
			if (rw <= 0)
			{
				obj.graphics.drawRect(x, y, w, h);
			}
			else
			{
				if (rh <= 0)
				{
					obj.graphics.drawRoundRect(x, y, w, h, rw);
				}
				else
				{
					obj.graphics.drawRoundRect(x, y, w, h, rw, rh);
				}
			}
			obj.graphics.endFill();
		}

		/**
		 * 画矢量矩框
		 * @param obj：被绘制的Sprite载体；
		 * @param x：矩框左上角x坐标；
		 * @param y：矩框左上角y坐标；
		 * @param w：矩框宽度；
		 * @param h：矩框高度；
		 * @param color：矩框边框颜色；
		 * @param alp：矩框边框透明度；
		 * @param thickness：矩框边框粗细；
		 * @param rw：矩框圆角宽度；
		 * @param rh：矩框圆角高度；
		 * @param mode：矩框填充模式；
		 * @param pixelHinting：笔触是否采用完整象素；
		 * @param scaleMode：线条缩放模式；
		 * @param caps：线头模式；
		 * @param joints：拐角的连接外观的类型；
		 * @param miterLimit：切断尖角的位置；
		 */
		public static function drawRectBorder(obj:*, x:Number=0, y:Number=0, w:Number=DEFAULT_W, h:Number=DEFAULT_H, color:uint=DEFAULT_BORDER_COLOR, alp:Number=DEFAULT_BORDER_ALP, thickness:Number=DEFAULT_THICKNESS, rw:Number=DEFAULT_RW, rh:Number=DEFAULT_RH, mode:String="inner", pixelHinting:Boolean=false, scaleMode:String="none", caps:String=null, joints:String=null, miterLimit:Number=3):void
		{
			obj.graphics.lineStyle(thickness, color, alp, pixelHinting, scaleMode, caps, joints, miterLimit);
			obj.graphics.beginFill(0xFFFFFF, 0);
			if (rw <= 0)
			{
				switch (mode)
				{
					case BorderFillLayout.INNER:
						obj.graphics.drawRect(x + thickness / 2, y + thickness / 2, w - thickness, h - thickness);
						break;
					case BorderFillLayout.MIDDLE:
						obj.graphics.drawRect(x, y, w, h);
						break;
					case BorderFillLayout.OUTER:
						obj.graphics.drawRect(x - thickness / 2, y - thickness / 2, w + thickness, h + thickness);
						break;
				}
			}
			else
			{
				if (rh <= 0)
				{
					switch (mode)
					{
						case BorderFillLayout.INNER:
							obj.graphics.drawRoundRect(x + thickness / 2, y + thickness / 2, w - thickness, h - thickness, rw);
							break;
						case BorderFillLayout.MIDDLE:
							obj.graphics.drawRoundRect(x, y, w, h, rw);
							break;
						case BorderFillLayout.OUTER:
							obj.graphics.drawRoundRect(x - thickness / 2, y - thickness / 2, w + thickness, h + thickness, rw);
							break;
					}
				}
				else
				{
					switch (mode)
					{
						case BorderFillLayout.INNER:
							obj.graphics.drawRoundRect(x + thickness / 2, y + thickness / 2, w - thickness, h - thickness, rw, rh);
							break;
						case BorderFillLayout.MIDDLE:
							obj.graphics.drawRoundRect(x, y, w, h, rw, rh);
							break;
						case BorderFillLayout.OUTER:
							obj.graphics.drawRoundRect(x - thickness / 2, y - thickness / 2, w + thickness, h + thickness, rw, rh);
							break;
					}
				}
			}
			obj.graphics.endFill();
		}

		/**
		 *画矢量圆
		 * @param obj：被绘制的Sprite载体；
		 * @param x：圆心x坐标；
		 * @param y：圆心y坐标；
		 * @param radius：圆面半径；
		 * @param bgColor：圆面填充色；
		 * @param bgAlp：圆面透明度；
		 * @param borderColor：圆圈颜色；
		 * @param borderAlp：圆圈透明度；
		 * @param thickness：粗细；
		 * @param mode：填充模式；
		 * @param pixelHinting：笔触是否采用完整象素；
		 * @param scaleMode：线条缩放模式；
		 * @param caps：线头模式；
		 * @param joints：拐角的连接外观的类型；
		 * @param miterLimit：切断尖角的位置；
		 */
		public static function drawCircle(obj:*, x:Number=0, y:Number=0, radius:Number=10, bgColor:Number=DEFAULT_BG_COLOR, bgAlp:Number=DEFAULT_BG_ALP, borderColor:uint=DEFAULT_BORDER_COLOR, borderAlp:Number=DEFAULT_BORDER_ALP, thickness:Number=DEFAULT_THICKNESS, mode:String="inner", pixelHinting:Boolean=false, scaleMode:String="none", caps:String=null, joints:String=null, miterLimit:Number=3):void
		{
			drawCircleArea(obj, x, y, radius, bgColor, bgAlp)
			drawCircleBorder(obj, x, y, radius, borderColor, borderAlp, thickness, mode, pixelHinting, scaleMode, caps, joints, miterLimit);
		}

		/**
		 *画矢量圆面
		 * @param obj：被绘制的Sprite载体；
		 * @param x：圆心x坐标；
		 * @param y：圆心y坐标；
		 * @param radius：半径；
		 * @param color：填充色；
		 * @param alp：透明度；
		 */
		public static function drawCircleArea(obj:*, x:Number=0, y:Number=0, radius:Number=10, color:Number=DEFAULT_BG_COLOR, alp:Number=DEFAULT_BG_ALP):void
		{
			obj.graphics.beginFill(color, alp);
			obj.graphics.drawCircle(x, y, radius);
			obj.graphics.endFill();
		}

		/**
		 *画矢量圆圈
		 * @param obj：被绘制的Sprite载体；
		 * @param x：圆心x坐标；
		 * @param y：圆心y坐标；
		 * @param radius：半径；
		 * @param color：颜色；
		 * @param alp：透明度；
		 * @param thickness：粗细；
		 * @param mode：填充模式；
		 * @param pixelHinting：笔触是否采用完整象素；
		 * @param scaleMode：线条缩放模式；
		 * @param caps：线头模式；
		 * @param joints：拐角的连接外观的类型；
		 * @param miterLimit：切断尖角的位置；
		 */
		public static function drawCircleBorder(obj:*, x:Number=0, y:Number=0, radius:Number=10, color:Number=DEFAULT_BORDER_COLOR, alp:Number=DEFAULT_BORDER_ALP, thickness:Number=DEFAULT_THICKNESS, mode:String="inner", pixelHinting:Boolean=false, scaleMode:String="none", caps:String=null, joints:String=null, miterLimit:Number=3):void
		{
			obj.graphics.lineStyle(thickness, color, alp, pixelHinting, scaleMode, caps, joints, miterLimit);
			obj.graphics.beginFill(0xFFFFFF, 0);
			switch (mode)
			{
				case BorderFillLayout.INNER:
					obj.graphics.drawCircle(x, y, radius - thickness / 2);
					break;
				case BorderFillLayout.MIDDLE:
					obj.graphics.drawCircle(x, y, radius);
					break;
				case BorderFillLayout.OUTER:
					obj.graphics.drawCircle(x, y, radius + thickness / 2);
					break;
			}
			obj.graphics.endFill();
		}

		/**
		 * 三点法画任意三角形
		 * @param obj：被绘制的Sprite载体；
		 * @param pA：顶点A；
		 * @param pB：顶点B；
		 * @param pC：顶点C；
		 * @param bgColor：三角面颜色；
		 * @param bgAlp：三角面透明度；
		 * @param borderColor：三角框颜色；
		 * @param borderAlp：三角框透明度；
		 * @param thickness：粗细；
		 * @param pixelHinting：笔触是否采用完整象素；
		 * @param scaleMode：线条缩放模式；
		 * @param caps：线头模式；
		 * @param joints：拐角的连接外观的类型；
		 * @param miterLimit：切断尖角的位置；
		 */
		public static function drawTriangle(obj:*, pA:Point, pB:Point, pC:Point, bgColor:uint=DEFAULT_BG_COLOR, bgAlp:Number=DEFAULT_BG_ALP, borderColor:uint=DEFAULT_BORDER_COLOR, borderAlp:Number=DEFAULT_BORDER_ALP, thickness:Number=1, pixelHinting:Boolean=false, scaleMode:String="none", caps:String=null, joints:String=null, miterLimit:Number=3):void
		{
			drawTriangleArea(obj, pA, pB, pC, bgColor, bgAlp);
			drawTriangleBorder(obj, pA, pB, pC, borderColor, borderAlp, thickness, pixelHinting, scaleMode, caps, joints, miterLimit)
		}

		/**
		 * 三点法画任意三角面
		 * @param obj：被绘制的Sprite载体；
		 * @param pA：顶点A；
		 * @param pB：顶点B；
		 * @param pC：顶点C；
		 * @param color：颜色；
		 * @param alp：透明度；
		 */
		public static function drawTriangleArea(obj:*, pA:Point, pB:Point, pC:Point, color:uint=DEFAULT_BORDER_COLOR, alp:Number=DEFAULT_BG_ALP):void
		{
			obj.graphics.beginFill(color, alp);
			obj.graphics.moveTo(pA.x, pA.y);
			obj.graphics.lineTo(pB.x, pB.y);
			obj.graphics.lineTo(pC.x, pC.y);
			obj.graphics.endFill();
		}

		/**
		 * 三点法画任意三角框
		 * @param obj：被绘制的Sprite载体；
		 * @param pA：顶点A；
		 * @param pB：顶点B；
		 * @param pC：顶点C；
		 * @param color：颜色；
		 * @param alp：透明度；
		 * @param thickness：粗细；
		 * @param pixelHinting：笔触是否采用完整象素；
		 * @param scaleMode：线条缩放模式；
		 * @param caps：线头模式；
		 * @param joints：拐角的连接外观的类型；
		 * @param miterLimit：切断尖角的位置；
		 */
		public static function drawTriangleBorder(obj:*, pA:Point, pB:Point, pC:Point, color:uint=DEFAULT_BORDER_COLOR, alp:Number=DEFAULT_BORDER_ALP, thickness:Number=DEFAULT_THICKNESS, pixelHinting:Boolean=false, scaleMode:String="none", caps:String=null, joints:String=null, miterLimit:Number=3):void
		{
			obj.graphics.lineStyle(thickness, color, alp, pixelHinting, scaleMode, caps, joints, miterLimit);
			obj.graphics.beginFill(0xFFFFFF, 0);
			obj.graphics.moveTo(pA.x, pA.y);
			obj.graphics.lineTo(pB.x, pB.y);
			obj.graphics.lineTo(pC.x, pC.y);
			obj.graphics.endFill();
		}

		/**
		 * 清除显示对象的绘制；
		 * @param obj
		 */
		public static function clear(obj:*):void
		{
			obj.graphics.clear();
		}
	}
}