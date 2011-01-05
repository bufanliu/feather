package org.feather.lib.layout
{

	/**
	 * 显示对象在容器内的缩放模式
	 * @author Aaron Wei
	 * @email weilong1@staff.sina.com.cn
	 * @msn asianfalcon@msn.com
	 * @qq 120020062
	 * @copy Copyright © 1996 - 2012 SINA Corporation, All Rights Reserved
	 */
	public class DisplayObjectScale
	{
		/**
		 * 可自由设置显示对象尺寸的模式，其他模式下尺寸设计失效，模式优先级高于尺寸设置
		 */
		public static const NONE:String=null;
		/**
		 * 保持显示对象不做任何缩放
		 */
		public static const NO_SCALE:String="noScale";
		/**
		 * 平铺
		 */
		public static const TILE:String="tile";
		/**
		 * 等比缩放
		 */
		public static const SCALE:String="scale";
		/**
		 * 拉伸/不拉伸填充满
		 */
		public static const FIT:String="fit";

	}
}