package org.feather.lib.layout
{
	import flash.events.Event;
	import flash.filters.*;
	import flash.geom.Point;

	import org.feather.utils.Debugger;
	import org.feather.utils.display.Drawer;

	/**
	 * 提示框
	 * @author Aaron Wei
	 * @email weilong1@staff.sina.com.cn
	 * @msn asianfalcon@msn.com
	 * @qq 120020062
	 * @copy Copyright © 1996 - 2012 SINA Corporation, All Rights Reserved
	 */
	public class Tip extends ProSprite
	{
		/**tip锚点*/
		protected var _anchor:Point;
		/**锚边长度*/
		private var _len:Number;
		/**tip主对话框中心点*/
		private var _center:Point;
		private var _pA:Point;
		private var _pB:Point;
		/**滤镜*/
		private var _dropShadow:DropShadowFilter;
		private var _colorMatrix:ColorMatrixFilter;

		public function Tip(style:Object=null):void
		{
			super(style);
		}

		override protected function commitProperties():void
		{
			_style.wsize=_wsize=(_style && (_style.wsize || _style.wsize === 0)) ? _style.wsize : 200;
			_style.hsize=_hsize=(_style && (_style.hsize || _style.hsize === 0)) ? _style.hsize : 100;
			super.commitProperties();
			_style.anchor=_anchor=_style && _style.anchor ? new Point(_anchor.x - x, _anchor.y - y) : new Point(_wsize / 2 + _startX, _hsize + _startY + 50);
			_style.len=_len=_style && _style.len ? style.len : 30;
			calcProperties();
			_dropShadow=new DropShadowFilter(2, 45, 0x0077FF, 1, 8, 8, 1);
			var matrix:Array=new Array();
			matrix=matrix.concat([1, 0, 0, 0, 0]); // red
			matrix=matrix.concat([0, 1, 0, 0, 0]); // green
			matrix=matrix.concat([0, 0, 1, 0, 0]); // blue
			matrix=matrix.concat([0, 0, 0, 0.2, 0]); // alpha
			_colorMatrix=new ColorMatrixFilter(matrix);
		}

		private function calcProperties():void
		{
			_center=new Point(_wsize / 2 + _startX, _hsize / 2 + _startY);
			_pA=new Point(_center.x - (_anchor.y - _center.y) * _len / (Point.distance(_anchor, _center)), _center.y - (_center.x - _anchor.x) * _len / (Point.distance(_anchor, _center)));
			_pB=new Point(_center.x * 2 - _pA.x, _center.y * 2 - _pA.y);
		}

		override protected function draw(e:Event=null):void
		{
			if (((e && e.eventPhase != 3) || !e) && this.parent)
			{
				calcProperties();
				super.draw();
				Debugger.debug("draw:" + e, this);
				Drawer.drawTriangleArea(this, _anchor, _pA, _pB, _bgColor, _bgAlp);
				this.filters=[_dropShadow, _colorMatrix];
			}
		}

		public function get anchor():Point
		{
			return _anchor;
		}

		public function set anchor(p:Point):void
		{
			if (p.x !== _anchor.x || p.y !== _anchor.y)
			{
				_changed=true;
				_style.anchor=_anchor=new Point(p.x - x, p.y - y);
			}
			validate();
		}

	}
}