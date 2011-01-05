package org.feather.utils
{
	/**
	 *从实例获取类
	 * @param instance：被获取的实例；
	 * @return：该实例所属的类
	 */
	public function getClassByInstance(instance:Object):Class
	{
		var myClass:Class=Object(instance).constructor;
		return myClass;
	}
}