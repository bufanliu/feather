package org.feather.utils
{
	import flash.utils.getQualifiedClassName;

	/**
	 * 获取对象的类名.
	 *
	 * <p>不同于getQualifiedClassName,该方法获取的只是类对象的不完全限定类名,也就是不含有路径的类名.</p>
	 *
	 * @param arg 目标对象.可以是对象实例,原始类型或者类对象.
	 *
	 * @return 目标对象的类名.
	 */
	public function getClassShortName(arg:Object):String
	{
		return getQualifiedClassName(arg).split(":").pop();
	}
}