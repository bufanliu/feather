package org.feather.lib.layout
{
	import flash.display.Shape;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;

	import org.feather.utils.geom.Drawer;
	import org.feather.config.LayoutConfig;
	import org.feather.utils.Debugger;
	import org.feather.lib.core.UIComponentStyle;

	/**
	 * 标签类
	 * @author Aaron Wei
	 * @email weilong1@staff.sina.com.cn
	 * @msn asianfalcon@msn.com
	 * @qq 120020062
	 * @copy Copyright © 1996 - 2012 SINA Corporation, All Rights Reserved
	 */ /**
	 *
	 * @author Aaron
	 */
	public class LabelSub extends Container
	{
		protected var _text:TextField;
		protected var _textFormat:TextFormat;
		protected var _textMask:Shape;

		protected var _align:String;
		protected var _autoSize:Boolean;

		protected var LABEL_DEFAULT_W:Number=100;
		protected var LABEL_DEFAULT_H:Number=21;
		protected var LABEL_DEFAULT_ALIGN:String=TextFieldAutoSize.CENTER;

		public function LabelSub(info:Object=null):void
		{
			super(info);
		}

		override protected function initialize():void
		{
			super.initialize();
			if (_isParamNull)
			{
				_wsize=_style.wsize=LABEL_DEFAULT_W;
				_hsize=_style.hsize=LABEL_DEFAULT_H;
			}
			else
			{
				_wsize=_style ? _style.wsize : LayoutConfig.DEFAULT_W;
				_hsize=_style ? _style.hsize : LayoutConfig.DEFAULT_H;
			}
			_align=_style ? _style.labelAlign : LABEL_DEFAULT_ALIGN;
			_autoSize=_style ? _style.LabelAutoSize : false;
			_text=new TextField();
			_text.autoSize=TextFieldAutoSize.LEFT;
			_textFormat=new TextFormat();
		}

		private function optionTextField():void
		{
			if (_autoSize)
			{
				switch (_borderLayout)
				{
					case "inner":
						_wsize=_style.wsize=_text.width + _thickness * 2;
						_hsize=_style.hsize=_text.height + _thickness * 2;
						_text.x=thickness;
						_text.y=thickness;
						break;
					case "center":
						_wsize=_style.wsize=_text.width + _thickness;
						_hsize=_style.hsize=_text.height + _thickness;
						_text.x=thickness / 2;
						_text.y=thickness / 2;
						break;
					case "outer":
						_wsize=_style.wsize=_text.width;
						_hsize=_style.hsize=_text.height;
						_text.x=0;
						_text.y=0;
						break;
				}
			}
			else
			{
				switch (_borderLayout)
				{
					case "inner":
						if (_align == "left")
						{
							_text.x=_thickness;
							_text.y=_thickness;
						}
						else if (_align == "center")
						{
							_text.x=(_wsize - _text.width) / 2;
							_text.y=(_hsize - _text.height) / 2;
						}
						else if (_align == "right")
						{
							_text.x=_wsize - _text.width - _thickness;
							_text.y=_hsize - _text.height - _thickness;
						}
						break;
					case "middle":
						if (_align == "left")
						{
							_text.x=_thickness / 2;
							_text.y=_thickness / 2;
						}
						else if (_align == "center")
						{
							_text.x=(_wsize - _text.width) / 2;
							_text.y=(_hsize - _text.height) / 2;
						}
						else if (_align == "right")
						{
							_text.x=_wsize - _text.width - _thickness / 2;
							_text.y=_hsize - _text.height - _thickness / 2;
						}
						break;
					case "outer":
						if (_align == "left")
						{
							_text.x=0;
							_text.y=0;
						}
						else if (_align == "center")
						{
							_text.x=(_wsize - _text.width) / 2;
							_text.y=(_hsize - _text.height) / 2;
						}
						else if (_align == "right")
						{
							_text.x=_wsize - _text.width;
							_text.y=_hsize - _text.height;
						}
						break;
				}
			}
		}

		/**
		 * 渲染UI
		 */
		override public function validateNow(e:Event=null):void
		{
			Debugger.debug("render:" + e, this);
			if (((e && e.eventPhase != 3) || !e) && this.parent)
			{
				Debugger.debug("render:success", this);
				optionTextField();
				super.validateNow(e);
				if (!contains(_text))
				{
					addChild(_text);
				}
				_textMask=_textMask ? _textMask : new Shape();
				Drawer.clear(_textMask);
				switch (_borderLayout)
				{
					case "inner":
						Drawer.drawRectArea(_textMask, _thickness, _thickness, _wsize - _thickness * 2, _hsize - _thickness * 2);
						break;
					case "middle":
						Drawer.drawRectArea(_textMask, _thickness / 2, _thickness / 2, _wsize - _thickness, _hsize - _thickness);
						break;
					case "outer":
						Drawer.drawRectArea(_textMask, 0, 0, _wsize, _hsize);
						break;
				}
				addChild(_textMask);
				_text.mask=_textMask;
			}
		}

		/**
		 * 获取Label的文本域
		 * @return Label的文本域
		 */
		public function get textField():TextField
		{
			return _text as TextField;
		}

		/**
		 * 指定Label的文本域
		 * @param t：Label的文本域
		 */
		public function set textField(t:TextField):void
		{
			_text=t as TextField;
		}

		/**
		 * 获取Label的文本格式
		 * @return Label的文本格式
		 */
		public function get textFormat():TextFormat
		{
			return _textFormat;
		}

		/**
		 * 设置Label的文本格式
		 * @param f：Label的文本格式
		 */
		public function set textFormat(f:TextFormat):void
		{
			_textFormat=f;
		}

		/**
		 * 获取Label的文本内容
		 * @return Label的文本内容
		 */
		public function get text():String
		{
			return _text.text;
		}

		/**
		 * 设置Label的文本内容
		 * @param t：Label的文本内容
		 */
		public function set text(t:String):void
		{
			_text.text=t;
			update();
		}

		/**
		 * 设置Label自宽
		 * @param w：Label自宽
		 */
		override public function set wsize(w:Number):void
		{
			_wsize=_style.wsize=w;
			update();
		}

		/**
		 * 设置Label自高
		 * @param h：Label自高
		 */
		override public function set hsize(h:Number):void
		{
			_hsize=_style.hsize=h;
			update();
		}

		public function get align():String
		{
			return _align;
		}

		public function set align(str:String):void
		{
			_text.autoSize=_align=_style.labelAlign=str;
			update();
		}

		public function get autoSize():Boolean
		{
			return _autoSize;
		}

		public function set autoSize(boo:Boolean):void
		{
			_autoSize=_style.LabelAutoSize=boo;
			_text.autoSize=boo ? _align : TextFieldAutoSize.LEFT;
			update();
		}
	}
}