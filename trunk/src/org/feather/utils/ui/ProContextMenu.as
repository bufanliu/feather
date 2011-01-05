package org.feather.utils.ui
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuBuiltInItems;
	import flash.ui.ContextMenuItem;
	import flash.utils.Dictionary;

	import org.feather.utils.Debugger;

	/**
	 * 快速设置右键菜单类
	 * @author Aaron Wei
	 * @email weilong1@staff.sina.com.cn
	 * @msn asianfalcon@msn.com
	 * @qq 120020062
	 * @copy Copyright © 1996 - 2012 SINA Corporation, All Rights Reserved
	 */
	public class ProContextMenu
	{
		private static var _myContextMenu:ContextMenu;
		private static var _stage:Stage;
		/**
		 * @_itmes:所有菜单汇总
		 */
		private static var _menu:Object;
		/**
		 * @_builtInMenu:内置菜单数组
		 */
		private static var _builtInMenu:Array;
		/**
		 * @_customMenu:自定义菜单数组
		 */
		private static var _customMenu:Array;

		public static const ZOOM:String="zoom";
		public static const QUALITY:String="quality";
		public static const PRINT:String="print";
		public static const PLAY:String="string";
		public static const LOOP:String="loop";
		public static const REWIND:String="rewind";
		public static const SAVE:String="save";
		public static const FROWARDANDBACK:String="forwardAndBack"

		private static function init():void
		{
			_menu=(_menu == null) ? new Object() : _menu;
			_myContextMenu=(_myContextMenu == null) ? new ContextMenu() : _myContextMenu;
			_builtInMenu=(_builtInMenu == null) ? new Array() : _builtInMenu;
			_customMenu=(_customMenu == null) ? new Array() : _customMenu;
		}

		/**
		 * 设置鼠标右键全菜单
		 * @param menu 鼠标右键全菜单
		 */
		public static function set menu(menu:Object):void
		{
			_menu=(_menu == null) ? new Object() : _menu;
			_menu=menu;
			_builtInMenu=menu.builtIn;
			_customMenu=menu.custom;
			builtInMenu=_builtInMenu;
			customMenu=_customMenu;
		}

		/**
		 * 获取鼠标右键全菜单
		 * @return
		 */
		public static function get menu():Object
		{
			return _menu;
		}

		/**
		 * 显示鼠标右键菜单
		 * @return
		 */
		public static function show():void
		{
			showBuiltIn();
			showCustom();
		}

		/**
		 * 显示鼠标右键全菜单
		 */
		public static function showAll():void
		{
			showBuiltInAll();
			showCustom();
		}

		/**
		 * 隐藏鼠标右键全菜单
		 * @return
		 */
		public static function hide():void
		{
			hideBuiltIn();
			hideCustom();
		}

		/**
		 *  设置鼠标右键默认菜单
		 * @param menu 鼠标右键默认菜单
		 */
		public static function set builtInMenu(menu:Array):void
		{
			_myContextMenu=(_myContextMenu == null) ? new ContextMenu() : _myContextMenu;
			_builtInMenu=menu;
			hideBuiltIn();
			var defaultItems:ContextMenuBuiltInItems=_myContextMenu.builtInItems;
			for (var i:int; i < menu.length; i++)
			{
				defaultItems[menu[i]]=true;
			}
			(stage.getChildAt(0) as Sprite).contextMenu=_myContextMenu;
		}

		/**
		 * 获取鼠标右键默认菜单
		 * @return
		 */
		public static function get builtInMenu():Array
		{
			return _builtInMenu;
		}

		/**
		 *  显示鼠标右键默认全菜单
		 */
		public static function showBuiltInAll():void
		{
			_myContextMenu=(_myContextMenu == null) ? new ContextMenu() : _myContextMenu;
			var defaultItems:ContextMenuBuiltInItems=_myContextMenu.builtInItems;
			defaultItems.zoom=defaultItems.quality=defaultItems.print=defaultItems.play=defaultItems.loop=defaultItems.rewind=defaultItems.save=defaultItems.forwardAndBack=true;
			(stage.getChildAt(0) as Sprite).contextMenu=_myContextMenu;
		}

		/**
		 * 显示鼠标右键默认菜单
		 */
		public static function showBuiltIn():void
		{
			_myContextMenu=(_myContextMenu == null) ? new ContextMenu() : _myContextMenu;
			var defaultItems:ContextMenuBuiltInItems=_myContextMenu.builtInItems;
			for (var i:int; i < _builtInMenu.length; i++)
			{
				defaultItems[_builtInMenu[i]]=true;
			}
			(stage.getChildAt(0) as Sprite).contextMenu=_myContextMenu;
		}

		/**
		 * 隐藏鼠标右键默认菜单
		 */
		public static function hideBuiltIn():void
		{
			_myContextMenu=(_myContextMenu == null) ? new ContextMenu() : _myContextMenu;
			_myContextMenu.hideBuiltInItems();
			(stage.getChildAt(0) as Sprite).contextMenu=_myContextMenu;
		}

		/**
		 *  设置鼠标右键自定义菜单
		 * @param menu 鼠标右键自定义菜单
		 */
		public static function set customMenu(menu:Array):void
		{
			_myContextMenu=(_myContextMenu == null) ? new ContextMenu() : _myContextMenu;
			_customMenu=menu;
			for (var i:uint=0; i < menu.length; i++)
			{
				var myItemMenu:ContextMenuItem=new ContextMenuItem(menu[i]);
				_myContextMenu.customItems.push(myItemMenu);
			}
			(stage.getChildAt(0) as Sprite).contextMenu=_myContextMenu;
		}

		/**
		 * 获取鼠标右键自定义菜单
		 * @return
		 */
		public static function get customMenu():Array
		{
			return _customMenu;
		}

		/**
		 *  显示鼠标右键自定义菜单
		 */
		public static function showCustom():void
		{
			_myContextMenu=(_myContextMenu == null) ? new ContextMenu() : _myContextMenu;
			_customMenu=(_customMenu == null) ? new Array() : _customMenu;
			for (var i:uint=0; i < _customMenu.length; i++)
			{
				var myItemMenu:ContextMenuItem=new ContextMenuItem(_customMenu[i]);
				_myContextMenu.customItems.push(myItemMenu);
			}
			(stage.getChildAt(0) as Sprite).contextMenu=_myContextMenu;
		}

		/**
		 * 隐藏鼠标右键自定义菜单
		 */
		public static function hideCustom():void
		{
			_myContextMenu=(_myContextMenu == null) ? new ContextMenu() : _myContextMenu;
			_myContextMenu.customItems=[];
			(stage.getChildAt(0) as Sprite).contextMenu=_myContextMenu;
		}

		public static function set stage(obj:Stage):void
		{
			_stage=obj;
		}

		public static function get stage():Stage
		{
			return _stage;
		}
	}
}