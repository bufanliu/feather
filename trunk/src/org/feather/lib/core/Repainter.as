package org.feather.lib.core
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	import org.feather.utils.data.HashSetter;

	public class Repainter extends Object
	{
		private static var _instance:Repainter;
		private var _timer:Timer;
		private var _alwaysUseTimer:Boolean;
		private var _renderring:Boolean;
		private var _repaintQueue:HashSetter;
		private var _validateQueue:HashSetter;

		public function Repainter(singletoner:Singletoner)
		{
			super();
			if (!singletoner)
			{
				throw new Error("只能用getInstance()来获取实例");
			}
			_repaintQueue=new HashSetter();
			_validateQueue=new HashSetter();
			_renderring=false;
			_alwaysUseTimer=false;
			_timer=new Timer(19, 1);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerRender);
		}

		public static function getInstance():Repainter
		{
			if (!_instance)
			{
				_instance=new Repainter(new Singletoner());
			}
			return _instance as Repainter;
		}

		private function timerRender(e:TimerEvent):void
		{
			render();
			e.updateAfterEvent();
		}

		/**
		 * Every frame this method will be executed to invoke the painting of components needed.
		 */
		private function render(e:Event=null):void
		{
			if (e)
			{
				var st:Stage = e.currentTarget as Stage;
				st.removeEventListener(Event.RENDER, render);
			}
			var com:BaseUIComponent;
			_renderring=true;
			var processValidates:Array = _validateQueue.toArray();
			_validateQueue.clear();
			var n:int=processValidates.length;
			for (var i:int=0; i < n; i++)
			{
				com=processValidates[i];
					//com.validate();
			}
			var processRepaints:Array = _repaintQueue.toArray();
			_repaintQueue.clear();
			n=processRepaints.length;
			for (var j:int=0; j < n; j++)
			{
				com=processRepaints[j];
					//com.paintImmediately();
			}
			_renderring=false;
		}

		/**
		 * Regist A Component need to repaint.
		 * @see org.aswing.Component#repaint()
		 */
		public function addRepaintComponent(com:BaseUIComponent):void
		{
			_repaintQueue.add(com);
			renderLater(com);
		}

		/**
		 * Find the Component's validate root parent and regist it need to validate.
		 * @see org.aswing.Component#revalidate()
		 * @see org.aswing.Component#validate()
		 * @see org.aswing.Component#invalidate()
		 */
		public function addInvalidComponent(com:BaseUIComponent):void
		{
			var validateRoot:Component = getValidateRootComponent(com);
			if (validateRoot != null)
			{
				_validateQueue.add(validateRoot);
				renderLater(com);
			}
		}

		/**
		 * Regists it need to be validated.
		 * @see org.aswing.Component#validate()
		 */
		public function addInvalidRootComponent(com:BaseUIComponent):void
		{
			_validateQueue.add(com);
			renderLater(com);
		}

		private function renderLater(c:BaseUIComponent):void
		{
			var st:Stage = c.stage;
			if (_alwaysUseTimer || st == null || _renderring)
			{
				if (!_timer.running)
				{
					_timer.reset();
					_timer.start();
				}
			}
			else
			{
				st.addEventListener(Event.RENDER, render, false, 0, true);
				st.invalidate();
			}
		}

		/**
		 * If the ancestor of the component has no parent or it is isValidateRoot
		 * and it's parent are visible, then it will be the validate root component,
		 * else it has no validate root component.
		 */
		private function getValidateRootComponent(com:BaseUIComponent):BaseUIComponent
		{
			var validateRoot:BaseUIComponent = null;
			for (var i:BaseUIComponent=com; i != null; i=i.parent as BaseUIComponent)
			{
				if (i.isValidateRoot())
				{
					validateRoot=i;
					break;
				}
			}

			//var root:Component = null;
			//TODO: check if the root here is needed, if not delte the var declar
			for (i=validateRoot; i != null; i=i.getParent())
			{
				if (!i.isVisible())
				{
					//return null;
				}
			}
			return validateRoot;
		}

		/**
		 * Sets whether or not always use timer to trigger the repaint progress.
		 * By default it is false, means use stage Event.RENDER to trigger at most time.
		 * It is better smooth for the rendering for Event.RENDER way, but if you make AsWing
		 * components works with Flex component, you should change to timer way.
		 * @param b true to make it always use timer, false not.
		 * @param delay the timer delay, by default it is 19 ms.
		 */
		public function setAlwaysUseTimer(b:Boolean, delay:int=19):void
		{
			_alwaysUseTimer=b;
			_timer.delay=delay;
		}
	}
}

internal class Singletoner
{
}

