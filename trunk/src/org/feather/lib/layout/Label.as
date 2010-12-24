package org.feather.lib.layout
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.events.Event;

	import org.feather.lib.core.BaseUIComponent;
	import org.feather.lib.core.UIComponentStyle;
	import org.feather.utils.Debugger;
	import org.feather.utils.display.Drawer;

	/**
	 * 标签类
	 * @author Aaron Wei
	 * @email weilong1@staff.sina.com.cn
	 * @msn asianfalcon@msn.com
	 * @qq 120020062
	 * @copy Copyright © 1996 - 2012 SINA Corporation, All Rights Reserved
	 */
	public class Label extends BaseUIComponent
	{
		/**
		 * 获取或设置一个字符串，指示如何调整标签大小和对齐标签以适合其 text 属性的值
		 */
		protected var _autoSize:String;
		/**
		 * 获取或设置一个值，该值指示是否应从包含 HTML 文本的 Label 组件中删除额外空白，如空格和换行符
		 */
		protected var _condenseWhite:Boolean

		/**
		 * 获取或设置由 Label 组件显示的文本，包括表示该文本样式的 HTML 标签
		 */
		protected var _htmlText:String;

		/**
		 * 获取或设置一个值，指示文本是否可选
		 */
		protected var _selectable:Boolean;

		/**
		 * 获取或设置由 Label 组件显示的纯文本
		 */
		protected var _text:String;

		/**
		 * 对 Label 组件的内部文本字段的引用
		 */
		protected var _textField:TextField;

		/**
		 * 获取或设置一个值，指示文本字段是否支持自动换行
		 */
		protected var _wordWrap:Boolean;

		protected const LABEL_DEFAULT_W:Number=100;
		protected const LABEL_DEFAULT_H:Number=21;
		protected const LABEL_DEFAULT_ALIGN:String=TextFieldAutoSize.CENTER;


		public function Label(info:Object=null):void
		{
			super(info);
		}

		override protected function initData():void
		{
			super.initData();
			if (_isParamNull)
			{
				_wsize=_style.wsize=LABEL_DEFAULT_W;
				_hsize=_style.hsize=LABEL_DEFAULT_H;
			}
			_style.autoSize=_autoSize=_style && _style.autoSize ? _style.autoSize : TextFieldAutoSize.NONE;
			_style.selectable=_selectable=_style && _style.selectable ? _style.selectable : false;
			_style.condenseWhite=_condenseWhite=_style && _style.condenseWhite ? _style.condenseWhite : false;
			_style.wordWrap=_wordWrap=_style && _style.wordWrap ? _style.wordWrap : false;
			if (_style && _style.text)
			{
				_text=_style.text;
			}
			else
			{
				if (_style && _style.htmlText)
				{
					_htmlText=_style.htmlText;
				}
				else
				{
					_text="Label";
				}
			}
			_textField=_textField || new TextField();
		}

		/**
		 * 渲染UI
		 */
		override public function render(e:Event=null):void
		{
			Debugger.debug("render:" + e, this);
			if (((e && e.eventPhase != 3) || !e) && this.parent)
			{
				Debugger.debug("render:success", this);
				super.render();
				if (_textField)
				{
					_textField.autoSize=_autoSize;
					_textField.selectable=_selectable;
					_textField.condenseWhite=_condenseWhite;
					_textField.wordWrap=_wordWrap;
					if (_text)
					{
						_textField.text=_text;
					}
					else
					{
						_textField.htmlText=_htmlText;
					}
					_textField.width=_wsize;
					_textField.height=_hsize;
					if (!contains(_textField))
					{
						addChild(_textField);
					}
				}
			}
		}

		/**
		 * 获取Label的文本域
		 * @return Label的文本域
		 */
		public function get textField():TextField
		{
			return _textField as TextField;
		}

		/**
		 * 获取一个字符串，指示如何调整标签大小和对齐标签以适合其 text 属性的值
		 * @return
		 */
		public function get autoSize():String
		{
			return _autoSize;
		}

		/**
		 * 设置一个字符串，指示如何调整标签大小和对齐标签以适合其 text 属性的值
		 * @param str
		 */
		public function set autoSize(str:String):void
		{
			_style.autoSize=_autoSize=str;
			optionRender();
		}

		/**
		 * 获取一个值，指示文本是否可选
		 * @return
		 */
		public function get selectable():Boolean
		{
			return _selectable;
		}

		/**
		 * 设置一个值，指示文本是否可选
		 * @param boo
		 */
		public function set selectable(boo:Boolean):void
		{
			_style.selectable=_selectable=boo;
			optionRender();
		}

		/**
		 * 获取一个值，该值指示是否应从包含 HTML 文本的 Label 组件中删除额外空白，如空格和换行符
		 * @return
		 */
		public function get condenseWhite():Boolean
		{
			return _condenseWhite;
		}

		/**
		 * 设置一个值，该值指示是否应从包含 HTML 文本的 Label 组件中删除额外空白，如空格和换行符
		 * @param boo
		 */
		public function set condenseWhite(boo:Boolean):void
		{
			_style.condenseWhite=_condenseWhite=boo;
			optionRender();
		}

		/**
		 * 获取一个值，指示文本字段是否支持自动换行
		 * @return
		 */
		public function get wordWrap():Boolean
		{
			return _wordWrap;
		}

		/**
		 * 设置一个值，指示文本字段是否支持自动换行
		 * @param boo
		 */
		public function set wordWrap(boo:Boolean):void
		{
			_style.wordWrap=_wordWrap=boo;
			optionRender();
		}

		/**
		 * 获取由 Label 组件显示的纯文本
		 * @return
		 */
		public function get text():String
		{
			return _text;
		}

		/**
		 * 设置由 Label 组件显示的纯文本
		 * @param t
		 */
		public function set text(t:String):void
		{
			_style.text=_text=t;
			optionRender();
		}

		/**
		 * 获取由 Label 组件显示的文本，包括表示该文本样式的 HTML 标签
		 * @return
		 */
		public function get htmlText():String
		{
			return _htmlText;
		}

		/**
		 * 设置由 Label 组件显示的文本，包括表示该文本样式的 HTML 标签
		 * @param t
		 */
		public function set htmlText(t:String):void
		{
			_style.htmlText=_htmlText=t;
			optionRender();
		}

		/**
		 * 设置Label自宽
		 * @param w：Label自宽
		 */
		override public function set wsize(w:Number):void
		{
			_wsize=_style.wsize=w;
			optionRender();
		}

		/**
		 * 设置Label自高
		 * @param h：Label自高
		 */
		override public function set hsize(h:Number):void
		{
			_hsize=_style.hsize=h;
			optionRender();
		}
	}
}