package org.feather.utils
{
	/**
	 *  对数组元素进行随机的排序
	 * @author Aaron Wei
	 * @email weilong1@staff.sina.com.cn
	 * @msn asianfalcon@msn.com
	 * @qq 120020062
	 * @copy Copyright © 1996 - 2012 SINA Corporation, All Rights Reserved
	 */
	public function sortArrayRandomly(arr:Array):Array
	{
		arr.sort(function(a:*, b:*):int
			{
				return Math.floor(Math.random() * 3) - 1
			});
		return arr as Array;
	}
}