package org.feather.utils
{
	import flash.utils.getQualifiedSuperclassName;
	/**
	 * 获取对象基类的类名.
	 * 
	 * <p>不同于getQualifiedSuperclassName,该方法获取的只是对象基类的不完全限定类名,也就是不含有路径的类名.</p>
	 * 
	 * @param arg 目标对象.可以是对象实例,原始类型或者类对象.
	 * 
	 * @return 目标对象基类的类名.
	 */	
	public function getSuperClassShortName(arg:Object):String
	{
		return getQualifiedSuperclassName(arg).split(":").pop();
	}
}