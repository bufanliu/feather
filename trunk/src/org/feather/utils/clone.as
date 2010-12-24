package org.feather.utils
{
	import flash.utils.ByteArray;

	/**
	 *  对象克隆可以复制出一个和已存在对象相同的对象，并且两个对象没有关联
	 * @author Aaron Wei
	 * @email weilong1@staff.sina.com.cn
	 * @msn asianfalcon@msn.com
	 * @qq 120020062
	 * @copy Copyright © 1996 - 2012 SINA Corporation, All Rights Reserved
	 */
	public function clone(obj:Object):*
	{
		var copier:ByteArray = new ByteArray();
		copier.writeObject(obj);
		copier.position=0;
		return copier.readObject()
	}
}