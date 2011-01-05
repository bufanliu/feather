package org.feather.utils
{
	import flash.utils.describeType;

	/**
	 * 获取对象构造函数的参数长度.
	 *
	 * @param arg 目标对象.可以是对象实例,原始类型或者类对象.
	 *
	 * @return 目标对象构造函数的参数长度.
	 */
	public function getConstructorLength(arg:Object):uint
	{
		return describeType(arg is Class ? arg : arg.constructor).factory.constructor.parameter.length();
	}
}