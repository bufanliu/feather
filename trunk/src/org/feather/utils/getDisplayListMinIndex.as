package org.feather.utils
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	/**
	 * 获取显示列表最小索引
	 * @return
	 */
	public function getDisplayListMinIndex(arr:Array,container:*):uint
	{
		var i:int=0, len:int=arr.length, num:Number=Infinity;
		while (i < len && arr&&(arr[i] is DisplayObject)&&(container is DisplayObjectContainer))
		{
			num=container.getChildIndex(arr[i]) < num ? container.getChildIndex(arr[i]) : num;
			++i;
		}
		return num as uint;
	}
}