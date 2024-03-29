package org.feather.utils.system
{

	/**
	 * Flash Player 版本判断
	 * @author Aaron Wei
	 * @email weilong1@staff.sina.com.cn
	 * @msn asianfalcon@msn.com
	 * @qq 120020062
	 * @copy Copyright © 1996 - 2012 SINA Corporation, All Rights Reserved
	 */
	public class Version
	{
		/**
		 * <br>比较系统当前flashplayer版本是否满足软件运行最低版本；</br>
		 * <br>版本号的格式为：平台 (platform)，主版本号 (majorVersion)，次版本号 (minorVersion)、生成版本号 (buildNumber)，内部生成版本号 (internalBuildNumber)。</br>
		 * <br>平台的可能值有 "WIN"、"MAC" 以及 "UNIX"。 以下是一些版本信息示例：</br>
		 * <br>WIN 9,0,0,0  </br>
		 * <br>Flash Player 9 for Windows MAC 7,0,25,0</br>
		 * <br>Flash Player 7 for Macintosh UNIX 5,0,55,0</br>
		 * <br>Flash Player 5 for UNIX</br>
		 * <br>服务器字符串为 V</br>
		 * @param targ：目标版本；
		 * @return 结果为true则通过，满足最低运行版本，反之依然；
		 */
		static public function matchLowest(targ:String):Boolean
		{
			var targ_arr:Array=targ.split(",");
			var ver:String=Capabilities.version;
			var ver_arr:Array=ver.split(",");
			var ver_length:int=ver_arr.length;
			var result:Boolean=true;
			for (var i:int=1; i < ver_length; i++)
			{
				if (Number(ver_arr[i]) < Number(targ_arr[i - 1]))
				{
					result=false;
					break;
				}
			}
			return result;
		}
	}
}