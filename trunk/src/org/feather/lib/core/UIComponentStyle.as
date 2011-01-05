package org.feather.lib.core
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.geom.Rectangle;

	import org.feather.config.LayoutConfig;
	import org.feather.lib.layout.BorderFillLayout;

	public class UIComponentStyle
	{
		/**
		 * 自宽
		 * @default
		 */
		public var wsize:Number=LayoutConfig.DEFAULT_W;
		/**
		 * 自高
		 * @default
		 */
		public var hsize:Number=LayoutConfig.DEFAULT_H;
		/**
		 * 圆角宽
		 * @default
		 */
		public var rw:Number=LayoutConfig.DEFAULT_RW;
		/**
		 * 圆角高
		 * @default
		 */
		public var rh:Number=LayoutConfig.DEFAULT_RH;
		/**
		 * 背景色
		 * @default
		 */
		public var bgColor:uint=LayoutConfig.DEFAULT_BG_COLOR;
		/**
		 * 背景透明度
		 * @default
		 */
		public var bgAlp:Number=LayoutConfig.DEFAULT_BG_ALP;
		/**
		 * 粗细
		 * @default
		 */
		public var thickness:Number=LayoutConfig.DEFAULT_THICKNESS;
		/**
		 * 边框色
		 * @default
		 */
		public var borderColor:uint=LayoutConfig.DEFAULT_BORDER_COLOR;
		/**
		 * 边框透明度（有别于alpha）
		 * @default
		 */
		public var borderAlp:Number=LayoutConfig.DEFAULT_BG_ALP;
		/**
		 * 间隙
		 * @default
		 */
		public var padding:Object=null;
		/**
		 * 感应区域
		 * @default
		 */
		public var hitRect:Rectangle=null;
		/**
		 * 边框填充模式
		 * @default
		 */
		public var borderLayout:String=BorderFillLayout.INNER;
		/**
		 *笔触是否采用完整象素
		 * @default
		 */
		public var pixelHinting:Boolean=false;
		/**
		 *线条缩放模式
		 * @default
		 */
		public var scaleMode:String=LineScaleMode.NONE;
		/**
		 *线头模式
		 * @default
		 */
		public var caps:String=CapsStyle.ROUND;
		/**
		 *拐角的连接外观的类型
		 * @default
		 */
		public var joints:String=JointStyle.ROUND;
		/**
		 *切断尖角的位置
		 * @default
		 */
		public var miterLimit:Number=3;
		/**
		 * Label文本域
		 * @default
		 */
		public var text:TextField;
		/**
		 * Label文本样式
		 * @default
		 */
		public var textFormat:TextFormat;
		/**
		 * Label对齐方式
		 * @default
		 */
		public var labelAlign:String="center";
		/**
		 * Label自动大小
		 * @default
		 */
		public var LabelAutoSize:Boolean=false;

	}
}