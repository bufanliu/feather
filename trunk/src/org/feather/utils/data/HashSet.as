package org.feather.utils.data
{
	import flash.utils.Dictionary;

	/**
	 * A collection that contains no duplicate elements. More formally,
	 * sets contain no pair of elements e1 and e2 such that e1 === e2.
	 * @author Aaron Wei
	 * @email weilong1@staff.sina.com.cn
	 * @msn asianfalcon@msn.com
	 * @qq 120020062
	 * @copy Copyright © 1996 - 2012 SINA Corporation, All Rights Reserved
	 */
	public class HashSet extends Object
	{
		private var _length:int;
		private var _container:Dictionary;

		public function HashSet()
		{
			super();
			_container=new Dictionary();
			_length=0;
		}

		public function add(o:*):void
		{
			if (!contains(o))
			{
				_length++;
			}
			_container[o]=o;
		}

		public function addAll(arr:Array):void
		{
			for each (var k:*in arr)
			{
				add(k);
			}
		}

		public function remove(o:*):Boolean
		{
			if (contains(o))
			{
				delete _container[o];
				length--;
				return true;
			}
			return false;
		}

		public function removeAll(arr:Array):void
		{
			for each (var k:*in arr)
			{
				remove(k);
			}
			return;
		}

		public function contains(o:*):Boolean
		{
			return _container[o] !== undefined;
		}

		public function containsAll(arr:Array):Boolean
		{
			var i:int = 0;
			while (i < arr.length)
			{
				if (!contains(arr[i]))
				{
					return false;
				}
				i++;
			}
			return true;
		}

		public function foreach(func:Function):void
		{
			for each (var k:*in _container)
			{
				func(k);
			}
			return;
		}

		public function toArray():Array
		{
			var arr:* = new Array(_length);
			var i:int = 0;
			for each (var k:*in _container)
			{
				arr[i]=k;
				i++
			}
			return arr;
		}

		public function clear():void
		{
			_container=new Dictionary();
			_length=0;
			return;
		}

		public function size():int
		{
			return _length;
		}

		public function isEmpty():Boolean
		{
			return _length == 0;
		}
	}
}