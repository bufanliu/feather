package org.feather.config
{
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;

	import org.feather.lib.layout.BorderFillLayout;

	/**
	 *  sina包版面配置类
	 * @author Aaron Wei
	 * @email weilong1@staff.sina.com.cn
	 * @msn asianfalcon@msn.com
	 * @qq 120020062
	 * @copy Copyright © 1996 - 2012 SINA Corporation, All Rights Reserved
	 */
	public class LayoutConfig
	{
		public static var DEFAULT_W:Number=320;
		public static var DEFAULT_H:Number=240;

		public static var DEFAULT_RADIUS:Number=50;

		public static var DEFAULT_BG_COLOR:uint=0xEEEEEE;
		public static var DEFAULT_BG_ALP:Number=1;

		public static var DEFAULT_BORDER_COLOR:uint=0xDDDDDD;
		public static var DEFAULT_BORDER_ALP:Number=1;

		public static var DEFAULT_THICKNESS:Number=1;

		public static var DEFAULT_RW:Number=0;
		public static var DEFAULT_RH:Number=0;

		public static var DEFAULT_BORDER_LAYOUT:String=BorderFillLayout.INNER;

		public static var DEFAULT_PIXELHINTING:Boolean=false;
		public static var DEFAULT_SCALEMODE:String=LineScaleMode.NONE;
		public static var DEFAULT_CAPS:String=CapsStyle.ROUND;
		public static var DEFAULT_JOINTS:String=JointStyle.ROUND;
		public static var DEFAULT_MITERLIMIT:Number=3;
	}
}