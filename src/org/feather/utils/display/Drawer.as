package org.feather.utils.display
{
	import flash.display.CapsStyle;
	import flash.display.DisplayObject;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

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
		/**
		 * 画线段
		 * @param container:* — 容器；
		 * @param start:Point — 线段起点；
		 * @param end:Point — 线段终点；
		 * @param thickness:Number — 线段粗细；
		 * @param color:uint — 线段颜色；
		 * @param alpha:Number — 线段透明度；
		 * @param pixelHinting:Boolean — 笔触是否采用完整象素；
		 * @param scaleMode:String — 线条缩放模式；
		 * @param caps:String — 线头模式；
		 * @param joints:String — 拐角的连接外观的类型；
		 * @param miterLimit:Number — 切断尖角的位置；
		 */
		public static function drawLine(container:*, start:Point, end:Point, thickness:Number=1, color:uint=0xDDDDDD, alpha:Number=1, pixelHinting:Boolean=true, scaleMode:String="none", caps:String=null, joints:String=null, miterLimit:Number=3):void
		{
			container.graphics.lineStyle(thickness, color, alpha, pixelHinting, scaleMode, caps, joints, miterLimit);
			container.graphics.moveTo(start.x, start.y);
			container.graphics.lineTo(end.x, end.y);
		}

		/**
		 * 迅速连线
		 * @param container:Object — 容器；
		 * @param points:Array — 连线的各节点；
		 * @param thickness:uint — 线段粗细；
		 * @param color:uint — 线段颜色；
		 * @param alpha:Number — 线段透明度；
		 * @param pixelHinting:Boolean — 笔触是否采用完整象素；
		 * @param scaleMode:String — 线条缩放模式；
		 * @param caps:String — 线头模式；
		 * @param joints:String — 拐角的连接外观的类型；
		 * @param miterLimit:String — 切断尖角的位置；
		 */
		public static function drawLinesPromptly(container:*, points:Array, thickness:uint=1, color:uint=0xDDDDDD, alpha:Number=1, pixelHinting:Boolean=true, scaleMode:String="none", caps:String=null, joints:String=null, miterLimit:Number=3):void
		{
			var i:int=1, len:int=points.length;
			container.graphics.lineStyle(thickness, color, alpha, pixelHinting, scaleMode, caps, joints, miterLimit);
			container.graphics.moveTo(points[0].x, points[0].y);
			while (i < len)
			{
				container.graphics.lineTo(points[i].x, points[i].y);
				++i;
			}
		}

		/**
		 * 演示连线过程
		 * @param container:Object — 容器；
		 * @param points:Array — 连线的各节点；
		 * @param times:Array — 连接点的停留时间
		 * @param thickness:uint — 线段粗细；
		 * @param color:uint — 线段颜色；
		 * @param alpha:Number — 线段透明度；
		 * @param pixelHinting:Boolean — 笔触是否采用完整象素；
		 * @param scaleMode:String — 线条缩放模式；
		 * @param caps:String — 线头模式；
		 * @param joints:String — 拐角的连接外观的类型；
		 * @param miterLimit:String — 切断尖角的位置；
		 */
		public static function drawLines(container:*, points:Array, times:Array=null, thickness:uint=1, color:uint=0xDDDDDD, alpha:Number=1, pixelHinting:Boolean=true, scaleMode:String="none", caps:String=null, joints:String=null, miterLimit:Number=3):void
		{
			var i:int=1, len:int=points.length, timeout:Number, time:Number;
			container.graphics.lineStyle(thickness, color, alpha, pixelHinting, scaleMode, caps, joints, miterLimit);
			container.graphics.moveTo(points[0].x, points[0].y);
			draw();
			function draw():void
			{
				if (i < len)
				{
					time=times && times[i] && times[i] > 0 ? times[i] : 0;
					timeout=setTimeout(function():void
						{
							container.graphics.lineTo(points[i].x, points[i].y);
							++i;
							draw();
						}, time);
				}
				else
				{
					clearTimeout(timeout);
				}
			}
		}

		/**
		 * 画虚段
		 * @param container:* — 容器；
		 * @param start:Point — 线段起点；
		 * @param end:Point — 线段终点；
		 * @param len:Point:Number — 虚线单元长度；
		 * @param gap:Number — 虚线间隔长度；
		 * @param thickness:Number — 线段粗细；
		 * @param color:uint — 线段颜色；
		 * @param alpha:Number — 线段透明度；
		 * @param pixelHinting:Boolean — 笔触是否采用完整象素；
		 * @param scaleMode:String — 线条缩放模式；
		 * @param caps:String — 线头模式；
		 * @param joints:String — 拐角的连接外观的类型；
		 * @param miterLimit:Number — 切断尖角的位置；
		 */
		public static function drawDashed(container:*, start:Point, end:Point, len:Number=5, gap:Number=5, thickness:Number=1, color:uint=0xDDDDDD, alpha:Number=1, pixelHinting:Boolean=true, scaleMode:String="none", caps:String=null, joints:String=null, miterLimit:Number=3):void
		{
			container.graphics.lineStyle(thickness, color, alpha, pixelHinting, scaleMode, caps, joints, miterLimit);
			var max:Number=Point.distance(start, end);
			var i:Number=0;
			var p1:Point;
			var p2:Point;
			while (i < max)
			{
				p1=Point.interpolate(end, start, i / max);
				i+=len;
				if (i > max)
				{
					i=max
				}
				p2=Point.interpolate(end, start, i / max);
				container.graphics.moveTo(p1.x, p1.y);
				container.graphics.lineTo(p2.x, p2.y);
				i+=gap;
			}
		}

		/**
		 * 迅速连虚线
		 * @param container:Object — 容器；
		 * @param points:Array — 连线的各节点；
		 * @param len:Point:Number — 虚线单元长度；
		 * @param gap:Number — 虚线间隔长度；
		 * @param thickness:uint — 线段粗细；
		 * @param color:uint — 线段颜色；
		 * @param alpha:Number — 线段透明度；
		 * @param pixelHinting:Boolean — 笔触是否采用完整象素；
		 * @param scaleMode:String — 线条缩放模式；
		 * @param caps:String — 线头模式；
		 * @param joints:String — 拐角的连接外观的类型；
		 * @param miterLimit:String — 切断尖角的位置；
		 */
		public static function drawDashedsPromptly(container:*, points:Array, length:Number=5, gap:Number=5, thickness:uint=1, color:uint=0xDDDDDD, alpha:Number=1, pixelHinting:Boolean=true, scaleMode:String="none", caps:String=null, joints:String=null, miterLimit:Number=3):void
		{
			var i:int=0, len:int=points.length - 1;
			while (i < len)
			{
				drawDashed(container, points[i], points[i + 1], length, gap, thickness, color, alpha, pixelHinting, scaleMode, caps, joints, miterLimit);
				++i;
			}
		}

		/**
		 * 演示虚线连线
		 * @param container:Object — 容器；
		 * @param points:Array — 连线的各节点；
		 * @param times:Array — 连接点的停留时间;
		 * @param length:Point:Number — 虚线单元长度；
		 * @param gap:Number — 虚线间隔长度；
		 * @param thickness:uint — 线段粗细；
		 * @param color:uint — 线段颜色；
		 * @param alpha:Number — 线段透明度；
		 * @param pixelHinting:Boolean — 笔触是否采用完整象素；
		 * @param scaleMode:String — 线条缩放模式；
		 * @param caps:String — 线头模式；
		 * @param joints:String — 拐角的连接外观的类型；
		 * @param miterLimit:String — 切断尖角的位置；
		 */
		private function drawDasheds(container:*, points:Array, times:Array=null, length:Number=5, gap:Number=5, thickness:uint=3, color:uint=0x333333, alpha:Number=1, pixelHinting:Boolean=true, scaleMode:String="none", caps:String=null, joints:String=null, miterLimit:Number=3):void
		{
			var i:int=0, len:int=points.length - 1, timeout:Number, time:Number;
			container.graphics.lineStyle(thickness, color, alpha, pixelHinting, scaleMode, caps, joints, miterLimit);
			draw();
			function draw():void
			{
				if (i < len)
				{
					time=times && times[i] && times[i] > 0 ? times[i] : 0;
					timeout=setTimeout(function():void
						{
							drawDashed(container, points[i], points[i + 1], length, gap, thickness, color, alpha, pixelHinting, scaleMode, caps, joints, miterLimit);
							++i;
							draw(i);
						}, time);
				}
				else
				{
					clearTimeout(timeout);
				}
			}
		}

		/**
		 * 画渐变线段
		 * @param container:* — 容器
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
		 * @param pixelHinting:Boolean — 笔触是否采用完整象素；
		 * @param scaleMode:String — 线条缩放模式；
		 * @param caps:String — 线头模式；
		 * @param joints:String — 拐角的连接外观的类型；
		 * @param miterLimit:Number — 切断尖角的位置；
		 */
		public static function drawGradientLine(container:*, start:Point, end:Point, type:String, colors:Array, alphas:Array, ratios:Array, thickness:uint=1, matrix:Matrix=null, spreadMethod:String=SpreadMethod.PAD, interpolationMethod:String="rgb", focalPointRatio:Number=0, pixelHinting:Boolean=true, scaleMode:String="none", caps:String=null, joints:String=null, miterLimit:Number=3):void
		{
			container.graphics.lineStyle(thickness);
			container.graphics.lineGradientStyle(type, colors, alphas, ratios, matrix, spreadMethod, interpolationMethod, focalPointRatio);
			container.graphics.moveTo(start.x, start.y);
			container.graphics.lineTo(end.x, end.y);
		}

		/**
		 * 画矢量矩形
		 * @param container:* — 被绘制的Sprite载体；
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
		public static function drawRect(container:*, x:Number=0, y:Number=0, w:Number=320, h:Number=240, bgColor:uint=0xEEEEEE, bgAlp:Number=1, rw:Number=0, rh:Number=0, thickness:Number=1, borderColor:uint=0xDDDDDD, borderAlp:Number=1, mode:String="inner", pixelHinting:Boolean=false, scaleMode:String="none", caps:String=null, joints:String=null, miterLimit:Number=3):void
		{
			drawRectArea(container, x, y, w, h, bgColor, bgAlp, rw, rh);
			drawRectBorder(container, x, y, w, h, borderColor, borderAlp, thickness, rw, rh, mode, pixelHinting, scaleMode, caps, joints, miterLimit);
		}

		/**
		 * 画矢量矩面
		 * @param container：被绘制的Sprite载体；
		 * @param x：矩面左上角x坐标；
		 * @param y：矩面左上角y坐标；
		 * @param w：矩面宽度；
		 * @param h：矩面高度；
		 * @param color：矩面颜色；
		 * @param alp：矩面透明度；
		 * @param rw：矩面圆角宽度；
		 * @param rh：矩面圆角高度；
		 */
		public static function drawRectArea(container:*, x:Number=0, y:Number=0, w:Number=320, h:Number=240, color:uint=0xEEEEEE, alp:Number=1, rw:Number=0, rh:Number=0):void
		{
			container.graphics.beginFill(color, alp);
			if (rw <= 0)
			{
				container.graphics.drawRect(x, y, w, h);
			}
			else
			{
				if (rh <= 0)
				{
					container.graphics.drawRoundRect(x, y, w, h, rw);
				}
				else
				{
					container.graphics.drawRoundRect(x, y, w, h, rw, rh);
				}
			}
			container.graphics.endFill();
		}

		/**
		 * 画矢量矩框
		 * @param container：被绘制的Sprite载体；
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
		public static function drawRectBorder(container:*, x:Number=0, y:Number=0, w:Number=320, h:Number=240, color:uint=0xDDDDDD, alp:Number=1, thickness:Number=1, rw:Number=0, rh:Number=0, mode:String="inner", pixelHinting:Boolean=false, scaleMode:String="none", caps:String=null, joints:String=null, miterLimit:Number=3):void
		{
			container.graphics.lineStyle(thickness, color, alp, pixelHinting, scaleMode, caps, joints, miterLimit);
			container.graphics.beginFill(0xFFFFFF, 0);
			if (rw <= 0)
			{
				switch (mode)
				{
					case BorderFillLayout.INNER:
						container.graphics.drawRect(x + thickness / 2, y + thickness / 2, w - thickness, h - thickness);
						break;
					case BorderFillLayout.MIDDLE:
						container.graphics.drawRect(x, y, w, h);
						break;
					case BorderFillLayout.OUTER:
						container.graphics.drawRect(x - thickness / 2, y - thickness / 2, w + thickness, h + thickness);
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
							container.graphics.drawRoundRect(x + thickness / 2, y + thickness / 2, w - thickness, h - thickness, rw);
							break;
						case BorderFillLayout.MIDDLE:
							container.graphics.drawRoundRect(x, y, w, h, rw);
							break;
						case BorderFillLayout.OUTER:
							container.graphics.drawRoundRect(x - thickness / 2, y - thickness / 2, w + thickness, h + thickness, rw);
							break;
					}
				}
				else
				{
					switch (mode)
					{
						case BorderFillLayout.INNER:
							container.graphics.drawRoundRect(x + thickness / 2, y + thickness / 2, w - thickness, h - thickness, rw, rh);
							break;
						case BorderFillLayout.MIDDLE:
							container.graphics.drawRoundRect(x, y, w, h, rw, rh);
							break;
						case BorderFillLayout.OUTER:
							container.graphics.drawRoundRect(x - thickness / 2, y - thickness / 2, w + thickness, h + thickness, rw, rh);
							break;
					}
				}
			}
			container.graphics.endFill();
		}

		/**
		 *画矢量圆
		 * @param container：被绘制的Sprite载体；
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
		public static function drawCircle(container:*, x:Number=0, y:Number=0, radius:Number=10, bgColor:Number=0xEEEEEE, bgAlp:Number=1, borderColor:uint=0xDDDDDD, borderAlp:Number=1, thickness:Number=1, mode:String="inner", pixelHinting:Boolean=false, scaleMode:String="none", caps:String=null, joints:String=null, miterLimit:Number=3):void
		{
			drawCircleArea(container, x, y, radius, bgColor, bgAlp)
			drawCircleBorder(container, x, y, radius, borderColor, borderAlp, thickness, mode, pixelHinting, scaleMode, caps, joints, miterLimit);
		}

		/**
		 *画矢量圆面
		 * @param container：被绘制的Sprite载体；
		 * @param x：圆心x坐标；
		 * @param y：圆心y坐标；
		 * @param radius：半径；
		 * @param color：填充色；
		 * @param alp：透明度；
		 */
		public static function drawCircleArea(container:*, x:Number=0, y:Number=0, radius:Number=10, color:Number=0xEEEEEE, alp:Number=1):void
		{
			container.graphics.beginFill(color, alp);
			container.graphics.drawCircle(x, y, radius);
			container.graphics.endFill();
		}

		/**
		 *画矢量圆圈
		 * @param container：被绘制的Sprite载体；
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
		public static function drawCircleBorder(container:*, x:Number=0, y:Number=0, radius:Number=10, color:Number=0xDDDDDD, alp:Number=1, thickness:Number=1, mode:String="inner", pixelHinting:Boolean=false, scaleMode:String="none", caps:String=null, joints:String=null, miterLimit:Number=3):void
		{
			container.graphics.lineStyle(thickness, color, alp, pixelHinting, scaleMode, caps, joints, miterLimit);
			container.graphics.beginFill(0xFFFFFF, 0);
			switch (mode)
			{
				case BorderFillLayout.INNER:
					container.graphics.drawCircle(x, y, radius - thickness / 2);
					break;
				case BorderFillLayout.MIDDLE:
					container.graphics.drawCircle(x, y, radius);
					break;
				case BorderFillLayout.OUTER:
					container.graphics.drawCircle(x, y, radius + thickness / 2);
					break;
			}
			container.graphics.endFill();
		}

		/**
		 * 三点法画任意三角形
		 * @param container：被绘制的Sprite载体；
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
		public static function drawTriangle(container:*, pA:Point, pB:Point, pC:Point, bgColor:uint=0xEEEEEE, bgAlp:Number=1, borderColor:uint=0xDDDDDD, borderAlp:Number=1, thickness:Number=1, pixelHinting:Boolean=false, scaleMode:String="none", caps:String=null, joints:String=null, miterLimit:Number=3):void
		{
			drawTriangleArea(container, pA, pB, pC, bgColor, bgAlp);
			drawTriangleBorder(container, pA, pB, pC, borderColor, borderAlp, thickness, pixelHinting, scaleMode, caps, joints, miterLimit)
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
		public static function drawTriangleArea(container:*, pA:Point, pB:Point, pC:Point, color:uint=0xDDDDDD, alp:Number=1):void
		{
			container.graphics.beginFill(color, alp);
			container.graphics.moveTo(pA.x, pA.y);
			container.graphics.lineTo(pB.x, pB.y);
			container.graphics.lineTo(pC.x, pC.y);
			container.graphics.endFill();
		}

		/**
		 * 三点法画任意三角框
		 * @param container：被绘制的Sprite载体；
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
		public static function drawTriangleBorder(container:*, pA:Point, pB:Point, pC:Point, color:uint=0xDDDDDD, alp:Number=1, thickness:Number=1, pixelHinting:Boolean=false, scaleMode:String="none", caps:String=null, joints:String=null, miterLimit:Number=3):void
		{
			container.graphics.lineStyle(thickness, color, alp, pixelHinting, scaleMode, caps, joints, miterLimit);
			container.graphics.beginFill(0xFFFFFF, 0);
			container.graphics.moveTo(pA.x, pA.y);
			container.graphics.lineTo(pB.x, pB.y);
			container.graphics.lineTo(pC.x, pC.y);
			container.graphics.endFill();
		}

		/**
		 * 清除显示对象的绘制；
		 * @param obj
		 */
		public static function clear(container:*):void
		{
			container.graphics.clear();
		}
	}
}