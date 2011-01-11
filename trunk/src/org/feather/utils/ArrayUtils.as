package org.feather.utils
{

	public class ArrayUtils
	{
		/**
		 *  对数组元素进行随机的排序
		 * @author Aaron Wei
		 * @email weilong1@staff.sina.com.cn
		 * @msn asianfalcon@msn.com
		 * @qq 120020062
		 * @copy Copyright © 1996 - 2012 SINA Corporation, All Rights Reserved
		 */
		public static function sortRandom(arr:Array):Array
		{
			arr.sort(function(a:*, b:*):int
				{
					return Math.floor(Math.random() * 3) - 1
				});
			return arr as Array;
		}
		
		/**
		 * Call the operation by pass each element of the array once.
		 * <p>
		 * for example:
		 * <pre>
		 * //hide all component in vector components
		 * ArrayUtils.each(
		 *     components,
		 *     function(c:Component){
		 *         c.setVisible(false);
		 *     });
		 * <pre>
		 * @param arr the array for each element will be operated.
		 * @param the operation function for each element
		 * @see Vector#each
		 */
		public static function each(arr:Array, operation:Function):void
		{
			for (var i:int=0; i < arr.length; i++)
			{
				operation(arr[i]);
			}
		}

		/**
		 * Sets the size of the array. If the new size is greater than the current size,
		 * new undefined items are added to the end of the array. If the new size is less than
		 * the current size, all components at index newSize and greater are removed.
		 * @param arr the array to resize
		 * @param size the new size of this vector
		 */
		public static function setSize(arr:Array, size:int):void
		{
			//TODO test this method
			if (size < 0)
				size=0;
			if (size == arr.length)
			{
				return;
			}
			if (size > arr.length)
			{
				arr[size - 1]=undefined;
			}
			else
			{
				arr.splice(size);
			}
		}

		/**
		 * Removes the object from the array and return the index.
		 * @return the index of the object, -1 if the object is not in the array
		 */
		public static function removeFromArray(arr:Array, obj:Object):int
		{
			for (var i:int=0; i < arr.length; i++)
			{
				if (arr[i] == obj)
				{
					arr.splice(i, 1);
					return i;
				}
			}
			return -1;
		}

		public static function removeAllFromArray(arr:Array, obj:Object):void
		{
			for (var i:int=0; i < arr.length; i++)
			{
				if (arr[i] == obj)
				{
					arr.splice(i, 1);
					i--;
				}
			}
		}

		public static function removeAllBehindSomeIndex(array:Array, index:int):void
		{
			if (index <= 0)
			{
				array.splice(0, array.length);
				return;
			}
			var arrLen:int=array.length;
			for (var i:int=index + 1; i < arrLen; i++)
			{
				array.pop();
			}
		}

		public static function indexInArray(arr:Array, obj:Object):int
		{
			for (var i:int=0; i < arr.length; i++)
			{
				if (arr[i] == obj)
				{
					return i;
				}
			}
			return -1;
		}

		public static function cloneArray(arr:Array):Array
		{
			return arr.concat();
		}
	}
}
