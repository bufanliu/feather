package org.feather.utils
{
	import flash.utils.describeType;

	/**
	 * 获取对象所实现的所有接口,以数组返回.
	 *
	 * @param arg 目标对象.可以是对象实例,原始类型或者类对象.
	 *
	 * @return 目标对象现实过的接口列表.
	 */
	public function getClassImplementedList(arg:Object):Array
	{
		var result:Array = new Array;
		var list:XMLList = describeType(arg is Class ? arg : arg.constructor).factory.implementsInterface;
		for each (var index:XML in list)
			result.push(index.@type.toString());
		list=null;
		return result;
	}
}