package org.feather.lib.controls
{

	/**
	 * 所有按钮组件的基类，用于定义所有按钮共有的属性和方法。 此类将处理绘制状态以及对按钮事件的调度
	 * @author Aaron Wei
	 * @email weilong1@staff.sina.com.cn
	 * @msn asianfalcon@msn.com
	 * @qq 120020062
	 * @copy Copyright © 1996 - 2012 SINA Corporation, All Rights Reserved
	 */
	public class LabelButton extends BaseButton
	{
		protected var _label:Label;
		
		public function LabelButton(style:Object=null)
		{
			super(style);

		}

		override protected function initData():void
		{
			_defaultSkin={up: null, over: null, down: null, disabled: null, reaction: null, label: null};
		}

	}
}