package org.feather.lib.controls
{
	import flash.text.TextField;
	import flash.text.TextFormat;
	/**
	 * 类是一个抽象类，用于向其父 BaseButton 类添加标签、图标及切换功能
	 * @author Aaron Wei
	 * @email weilong1@staff.sina.com.cn
	 * @msn asianfalcon@msn.com
	 * @qq 120020062
	 * @copy Copyright © 1996 - 2012 SINA Corporation, All Rights Reserved
	 */
	public class LabelButton extends BaseButton
	{
		protected var _label:String;
		
		public function LabelButton(style:Object=null)
		{
			super(style);
		}

		override protected function initData():void
		{
			super.initData();
			_label=_skin&&_skin.label?_skin.label:_defaultSkin.label;
		}
		public function get label():String
		{
			return _label;
		}
		public function set label(str:String):void
		{
			_label=str;
		}

	}
}