/*
VERSION: 1.0
DATE: 1/8/2009
ACTIONSCRIPT VERSION: 3.0 (AS2 version is also available)
UPDATES & MORE DETAILED DOCUMENTATION AT: http://www.TweenMax.com
DESCRIPTION:
	Tweens a BlurFilter. The following properties are available (you only need to define the ones you want to tween):
		- blurX : Number [0]
		- blurY : Number [0]
		- quality : uint [2]
		- index : uint
		- addFilter : Boolean [false]
		- remove : Boolean [false]
		
	Set remove to true if you want the filter to be removed when the tween completes.
	
USAGE:
	import gs.*;
	import gs.plugins.*;
	TweenPlugin.activate([BlurFilterPlugin]); //only do this once in your SWF to activate the plugin in TweenLite (it is already activated in TweenMax by default)
	
	TweenLite.to(mc, 1, {blurFilter:{blurX:10, blurY:10}});
	
	
BYTES ADDED TO SWF: 156 (not including dependencies)

AUTHOR: Jack Doyle, jack@greensock.com
Copyright 2009, GreenSock. All rights reserved. This work is subject to the terms in http://www.greensock.com/terms_of_use.html or for corporate Club GreenSock members, the software agreement that was issued with the corporate membership.
*/

package org.gs.plugins {
	import flash.filters.*;
	import flash.display.*;
	import org.gs.*;
	
	public class BlurFilterPlugin extends FilterPlugin {		
		public static const VERSION:Number = 1.0;
		public static const API:Number = 1.0; //If the API/Framework for plugins changes in the future, this number helps determine compatibility
		
		public function BlurFilterPlugin() {
			super();
			this.propName = "blurFilter";
			this.overwriteProps = ["blurFilter"];
		}
		
		override public function onInitTween($target:Object, $value:*, $tween:TweenLite):Boolean {
			_target = $target;
			_type = BlurFilter;
			initFilter($value, new BlurFilter(0, 0, $value.quality || 2));
			return true;
		}
		
	}
}