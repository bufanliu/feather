package org.feather.utils
{
	public class getFunctionName
	{
		/**
		 *通过脚本获取指定函数名称，基本思路:利用AS3的强制转换机制诱发错误, 然后从错误信息中提取函数名称.
		 * @param fun：被获取的函数
		 * @return：返回的函数名称
		 */
		public function getFunctionName(fun:Function):String
		{
			try
			{
				var k:Sprite=Sprite(fun);
			}
			catch (err:Error)
			{
				var fn:String=err.message.replace(/.+\/(\w+)\(\)\}\@.+/, "$1");
				return fn == err.message ? (err.message.replace(/.+ (function\-\d+) .+/i, "$1")) : fn;
			}
			return null;
		}
	}
}