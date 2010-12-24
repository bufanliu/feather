package org.feather.utils.data
{

	/**
	 * 参数设置
	 * @author Aaron Wei
	 * @email weilong1@staff.sina.com.cn
	 * @msn asianfalcon@msn.com
	 * @qq 120020062
	 * @copy Copyright © 1996 - 2012 SINA Corporation, All Rights Reserved
	 */
	public class Option extends Object
	{
		private var _obj:Object = null;

		public function Option(obj:Object)
		{
			super();
			_obj=obj;
		}

		public function apply(obj:Object):void
		{
			for (var key:Object in _obj)
			{
				if (obj.hasOwnProperty(key))
				{
					obj[key]=_obj[key];
				}
			}
		}
	}
}
