package org.feather.utils
{
	import flash.utils.describeType;

	/**
	 * 获取对象的构造函数详细资料,以数组返回.
	 *
	 * <p>返回的参数以数组存在.数组的每一项也是一个数组,而新的数组中第一项表示该参数的类型,第二项表示是否可选参数.</p>
	 * <p>例如调用getConstructorDetails(new Event(""));<br>那么返回的数组每一项如下值:
	 * <table class="innertable">
	 * <tr><th>数组索引</th><th>参数类型</th><th>可选参数</th><th>第几个参数</th></tr>
	 * <tr><td>0</td><td>String</td><td>true</td><td>1</td></tr>
	 * <tr><td>1</td><td>Boolean</td><td>false</td><td>2</td></tr>
	 * <tr><td>2</td><td>Boolean</td><td>false</td><td>3</td></tr>
	 * </table></p>
	 *
	 * 注意:当目标对象是类对象时,那么获取到的构造函数参数类型将全是"&#42;".
	 *
	 * @param arg 目标对象.可以是对象实例,原始类型或者类对象.
	 *
	 * @return 目标对象构造函数的详细资料.
	 */
	public function getConstructorDetails(arg:Object):Array
	{
		var result:Array = new Array;
		var list:XMLList = arg is Class ? describeType(arg).factory.constructor.parameter : describeType(arg).constructor.parameter;
		for each (var index:XML in list)
			result.push([index.@type, index.@optional == "false"]);
		list=null;
		return result;
	}
}