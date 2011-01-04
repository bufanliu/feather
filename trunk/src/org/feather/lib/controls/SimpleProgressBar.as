package org.feather.lib.controls
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.geom.Point;

	import org.feather.lib.core.BaseUIComponent;
	import org.feather.lib.core.UIComponentStyle;
	import org.feather.lib.layout.ProSprite;
	import org.feather.lib.geom.Rect;
	import org.feather.utils.Debugger;

	public class SimpleProgressBar extends BaseUIComponent
	{
		protected var _direction:String;
		protected var _rate:Number;
		protected var _bgBar:DisplayObject;
		protected var _progressBar:DisplayObject;
		protected var _headBar:ExtendedSimpleButton;
		protected var _interactiveArea:ProSprite;

		public function SimpleProgressBar(w:Number=100, h:Number=5, bg:DisplayObject=null, pg:DisplayObject=null, head:ExtendedSimpleButton=null, interactive:ProSprite=null, direction:String="leftToRight"):void
		{
			_rate=0;
			_wsize=w;
			_hsize=h;
			_bgBar=bg;
			_progressBar=pg;
			_headBar=head;
			_interactiveArea=interactive;
			_direction=direction;
			super();
		}

		/**
		 * 设置组件数据信息
		 * @param info
		 */
		override protected function initialize():void
		{
			_wsize=_wsize ? _wsize : 300;
			_hsize=_hsize ? _hsize : 5;
			_bgBar=_bgBar ? _bgBar : new Rect(new Point(0, 0), _wsize, _hsize, 0xFF0000, 1);
			_progressBar=_progressBar ? _progressBar : new Rect(new Point(0, 0), _wsize, _hsize, 0x00FF00, 1);
			if (!_headBar)
			{
				_headBar=new ExtendedSimpleButton();
				_headBar.upState=new Rect(new Point(-3.5, -3.5), 7, 7, 0xFFBB00, 1);
				_headBar.overState=new Rect(new Point(-3.5, -3.5), 7, 7, 0xFFDD00, 1);
				_headBar.downState=new Rect(new Point(-3.5, -3.5), 7, 7, 0xFFAA00, 1);
				_headBar.hitTestState=new Rect(new Point(-3.5, -3.5), 7, 7, 0x00FFFF, 1);
			}
			if (!_interactiveArea)
			{
				_interactiveArea=new ProSprite();
				_interactiveArea.wsize=_wsize;
				_interactiveArea.hsize=_hsize;
				_interactiveArea.bgColor=0x00FFFF;
				_interactiveArea.bgAlp=0;
			}
		}

		override public function validate(e:Event=null):void
		{
			if (_bgBar && !contains(_bgBar))
			{
				addChild(_bgBar)
			}
			_bgBar.x=_bgBar.y=0;
			_bgBar.width=_wsize;
			_bgBar.height=_hsize;

			if (_progressBar && !contains(_progressBar))
			{
				addChild(_progressBar);
			}
			_progressBar.x=_bgBar.x;
			_progressBar.y=_bgBar.y;
			_progressBar.width=_rate * _bgBar.width;
			_progressBar.height=_bgBar.height;

			if (_headBar && !contains(_headBar))
			{
				addChild(_headBar);
			}
			_headBar.x=_rate * _bgBar.width;
			_headBar.y=_bgBar.height / 2;

			if (_interactiveArea && !contains(_interactiveArea))
			{
				addChild(_interactiveArea);
			}
			_interactiveArea.x=_bgBar.x;
			_interactiveArea.y=_bgBar.y;
			_interactiveArea.width=_bgBar.width;
			_interactiveArea.height=_bgBar.height;
		}

		public function get rate():Number
		{
			return _rate as Number;
		}

		public function set rate(num:Number):void
		{
			if (num <= 0)
			{
				_rate=0;
			}
			else if (num > 0 && num < 1)
			{
				_rate=num;
			}
			else if (num >= 1)
			{
				_rate=1;
			}
			validate();
		}

		public function get direction():String
		{
			return _direction;
		}

		public function set direction(d:String):void
		{
			_direction=d;
		}

		public function get bgBar():DisplayObject
		{
			return _bgBar as DisplayObject;
		}

		public function set bgBar(bg:DisplayObject):void
		{
			_bgBar=bg as DisplayObject;
		}

		public function get progressBar():DisplayObject
		{
			return _progressBar as DisplayObject;
		}

		public function set progressBar(p:DisplayObject):void
		{
			_progressBar=p as DisplayObject;
		}

		public function get headBar():ExtendedSimpleButton
		{
			return _headBar as ExtendedSimpleButton;
		}

		public function set headBar(h:ExtendedSimpleButton):void
		{
			_headBar=h as ExtendedSimpleButton;
		}

		public function get interactiveArea():ProSprite
		{
			return _interactiveArea as ProSprite;
		}

		public function set interactiveArea(i:ProSprite):void
		{
			_interactiveArea=i as ProSprite;
		}
	}
}