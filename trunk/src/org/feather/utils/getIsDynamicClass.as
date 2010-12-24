package org.feather.utils
{
	import flash.utils.describeType;

	/**
	 * 获取对象是否是动态类.
	 *
	 * @param arg 目标对象.可以是对象实例,原始类型或者类对象.
	 *
	 * @return 如果目标对象是动态类,则为true.
	 */
	public function getIsDynamicClass(arg:Object):Boolean
	{
		return describeType(arg).@isDynamic == true;
	}
}