package org.feather.utils
{
	import flash.utils.describeType;

	/**
	 * 获取对象是否是密封类.
	 *
	 * @param arg 目标对象.可以是对象实例,原始类型或者类对象.
	 *
	 * @return 如果目标对象是密封类,则为true.
	 */
	public function getIsFinalClass(arg:Object):Boolean
	{
		return describeType(arg).@isFinal == true;
	}
}