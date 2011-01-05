package org.feather.lib.layout
{
	import flash.display.LineScaleMode;
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import org.feather.config.LayoutConfig;

	public class ContainerStyle extends ProSprite
	{
		/**
		 * 边框色
		 * @default
		 */
		public var borderColor:uint=LayoutConfig.DEFAULT_BG_COLOR;
		/**
		 * 边框透明度（有别于alpha）
		 * @default
		 */
		public var borderAlp:Number=LayoutConfig.DEFAULT_BG_ALP;
		/**
		 * 粗细
		 * @default
		 */
		public var thickness:Number=LayoutConfig.DEFAULT_THICKNESS;
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
	}
}