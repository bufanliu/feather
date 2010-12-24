package org.feather.utils
{
	import flash.utils.describeType;

	/**
	 * 获取对象所继承的所有父类,以数组返回.
	 *
	 * @param arg 目标对象.可以是对象实例,原始类型或者类对象.
	 *
	 * @return 目标对象父类列表.
	 */
	public function getClassExtendedList(arg:Object):Array
	{
		var result:Array = new Array;
		var list:XMLList = describeType(arg is Class ? arg : arg.constructor).factory.extendsClass;
		for each (var index:XML in list)
			result.push(index.@type.toString());
		list=null;
		return result;
	}
}