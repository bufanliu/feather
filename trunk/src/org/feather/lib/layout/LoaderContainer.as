package org.feather.lib.layout
{
	import flash.display.Loader;
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;

	import org.feather.lib.layout.DisplayObjectAlign;
	import org.feather.lib.layout.DisplayObjectScale;
	import org.feather.utils.Debugger;
	import org.feather.utils.display.Layout;
	import org.feather.utils.net.ProLoader;

	/**
	 * <b>单个加载显示容器</b><br>
	 * 一个容器只对应加载一个显示对象，提供加载源、回调、超时和样式设置API
	 * @author Aaron Wei
	 * @email weilong1@staff.sina.com.cn
	 * @msn asianfalcon@msn.com
	 * @qq 120020062
	 * @copy Copyright © 1996 - 2012 SINA Corporation, All Rights Reserved
	 */
	public class LoaderContainer extends Container
	{
		protected var _loader:ProLoader;
		protected var _callbackFun:Function;
		protected var _imgX:Number;
		protected var _imgY:Number;
		protected var _imgW:Number;
		protected var _imgH:Number;
		protected var _imgOriginalW:Number;
		protected var _imgOriginalH:Number;
		protected var _imgAlp:Number;
		protected var _img:Loader;
		protected var _imgScale:String;
		protected var _imgAlign:String;

		public function LoaderContainer(style:Object=null):void
		{
			super(style);
		}

		override protected function commitProperties():void
		{
			super.commitProperties();
			_style.imgX=_imgX=(_style && _style.imgX) ? _style.imgX : 0;
			_style.imgY=_imgY=(_style && _style.imgY) ? _style.imgY : 0;
			_style.imgW=_imgW=(_style && _style.imgW) ? _style.imgW : _wsize;
			_style.imgH=_imgH=(_style && _style.imgH) ? _style.imgH : _hsize;
			_style.imgAlp=_imgAlp=(_style && _style.imgAlp) ? _style.imgAlp : 1;
			_style.imgScale=_imgScale=(_style && _style.imgScale) ? _style.imgScale : null;
			_style.imgAlign=_imgAlign=(_style && _style.imgAlign) ? _style.imgAlign : null;
		}

		override protected function creatChildren():void
		{
			super.creatChildren();
			_loader=_loader || new ProLoader();
		}

		/**
		 * 取消当前正在对 Loader 实例执行的 load() 方法操作
		 */
		public function closeLoader():void
		{
			if (_loader)
			{
				_loader.close();
			}
		}

		/**
		 * 删除此 Loader 对象中使用 load() 方法加载的子项<br>
		 * 将关联 LoaderInfo 对象的 property 重置为 null，不必破坏子级，因为其它对象可能要引用它；<br>
		 * 但是它不再是 Loader 对象的子级
		 */
		public function unload():void
		{
			if (_loader)
			{
				_loader.unload();
			}
			if (_img)
			{
				if (contains(_img))
				{
					removeChild(_img);
				}
				_img=null;
			}
			_callbackFun=null;
		}

		public function load(url:String, callback:Function=null, timeout:Number=NaN):void
		{
			_callbackFun=callback;
			_loader=_loader || new ProLoader();
			_loader.close();
			_loader.load(url, onLoaded, timeout);
		}

		protected function onLoaded(obj:Object):void
		{
			switch (obj.info)
			{
				case "success":
					_img=obj.data as Loader;
					_imgOriginalW=_img.width;
					_imgOriginalH=_img.height;
					renderImg();
					break;
				case "ioError":
					break
				case "timeout":
					break;
			}
			if (_callbackFun != null)
			{
				try
				{
					_callbackFun({target: this, info: obj.info, spendTime: obj.spendTime});
				}
				catch (e:*)
				{
					Debugger.debug("onLoaded:error=" + e, this);
				}
			}
		}

		override public function validateNow(e:Event=null):void
		{
			super.validateNow(e);
			//renderImg();
		}

		protected function renderImg():void
		{
			if (_img)
			{
				addChild(_img);
				//模式优先级高于设置优先级
				switch (_imgScale)
				{
					case null:
						_img.width=_imgW;
						_img.height=_imgH;
						break;
					case "scale":
						Layout.prorataOV(_img, _wsize, _hsize);
						_imgW=_img.width;
						_imgH=_img.height;
						break;
					case "fit":
						_imgW=_img.width=_wsize;
						_imgH=_img.height=_hsize;
						break;
					case "noScale":
						_imgW=_img.width;
						_imgH=_img.height;
						break;
					case "tile":
						_imgW=_img.width;
						_imgH=_img.height;
						break;
				}
				switch (_imgAlign)
				{
					case null:
						_img.x=_imgX;
						_img.y=_imgY;
						break;
					case "center":
						Layout.setCenterOV(_img, _wsize, _hsize);
						_imgX=_img.x;
						_imgY=_img.y;
						break;
					case "top":
						Layout.setTopOV(_img, _wsize, _hsize);
						_imgX=_img.x;
						_imgY=_img.y;
						break;
					case "bottom":
						Layout.setBottomOV(_img, _wsize, _hsize);
						_imgX=_img.x;
						_imgY=_img.y;
						break;
					case "left":
						Layout.setLeftOV(_img, _wsize, _hsize);
						_imgX=_img.x;
						_imgY=_img.y;
						break;
					case "right":
						Layout.setRightOV(_img, _wsize, _hsize);
						_imgX=_img.x;
						_imgY=_img.y;
						break;
					case "leftTop":
						Layout.setLeftTopOV(_img, _wsize, _hsize);
						_imgX=_img.x;
						_imgY=_img.y;
						break;
					case "leftBottom":
						Layout.setLeftBottomOV(_img, _wsize, _hsize);
						_imgX=_img.x;
						_imgY=_img.y;
						break;
					case "rightTop":
						Layout.setRightTopOV(_img, _wsize, _hsize);
						_imgX=_img.x;
						_imgY=_img.y;
						break;
					case "rightBottom":
						Layout.setRightBottomOV(_img, _wsize, _hsize);
						_imgX=_img.x;
						_imgY=_img.y;
						break;
				}
			}
		}

		public function moveImg(x:Number, y:Number):void
		{
			if (_img)
			{
				if (!_imgAlign)
				{
					this.imgX=x;
					this.imgY=y;
				}
				else
				{
					throw new Error(getQualifiedClassName(this) + "   moveImg:当前为" + _imgAlign + "对齐模式，无法自定义坐标！");
				}
			}
		}

		public function get imgX():Number
		{
			return _imgX;
		}

		public function set imgX(x:Number):void
		{
			if (!_imgAlign)
			{
				_style.imgX=_imgX=x;
			}
			else
			{
				throw new Error(getQualifiedClassName(this) + "   imgX:当前为" + _imgAlign + "对齐模式，无法自定义坐标！");
			}

		}

		public function get imgY():Number
		{
			return _imgY;
		}

		public function set imgY(y:Number):void
		{
			if (_imgAlign)
			{
				_style.imgY=_imgY=y;
			}
			else
			{
				throw new Error(getQualifiedClassName(this) + "   imgY:当前为" + _imgAlign + "对齐模式，无法自定义坐标！");
			}
		}

		public function resizeImg(w:Number, h:Number):void
		{
			if (!_imgScale)
			{
				this.imgW=w;
				this.imgH=h;
			}
			else
			{
				throw new Error(getQualifiedClassName(this) + "   resizeImg:当前为" + _imgScale + "缩放模式，无法自定义尺寸！");
			}
		}

		public function get imgW():Number
		{
			return _imgW;
		}

		public function set imgW(w:Number):void
		{
			if (!_imgScale)
			{
				_imgW=w;
			}
			else
			{
				throw new Error(getQualifiedClassName(this) + "   imgW:当前为" + _imgScale + "缩放模式，无法自定义尺寸！");
			}
		}

		public function get imgH():Number
		{
			return _imgH;
		}

		public function set imgH(h:Number):void
		{
			if (!_imgScale)
			{
				_imgH=h;
			}
			else
			{
				throw new Error(getQualifiedClassName(this) + "   imgH:当前为" + _imgScale + "缩放模式，无法自定义尺寸！");
			}
		}

		public function get imgOriginalW():Number
		{
			return _imgOriginalW;
		}

		public function get imgOriginalH():Number
		{
			return _imgOriginalH;
		}
	}
}