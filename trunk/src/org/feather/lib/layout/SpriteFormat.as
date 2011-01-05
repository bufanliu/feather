package org.feather.lib.layout
{
	import flash.geom.Rectangle;

	import org.feather.config.LayoutConfig;

	/**
	 * ProSprite样式类
	 * @author Aaron
	 */
	public class SpriteFormat
	{
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
		 * 间隙
		 * @default
		 */
		public var padding:Object=null;
		/**
		 * 感应区域
		 * @default
		 */
		public var hitRect:Rectangle=null;
	}
}