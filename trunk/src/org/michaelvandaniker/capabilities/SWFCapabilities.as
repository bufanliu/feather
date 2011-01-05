package org.michaelvandaniker.capabilities
{
	/**
	 * How to check if you’re running a debug swf.    
	 * In a debug swf, the stack trace contains line number information that is absent in a release swf.<br/>
	 * To check if you’re in debug mode, all you have to do is throw an error, catch it, and check the stack trace for the square brackets that surround the line numbers.
	 * 
	 * Author's blog: http://michaelvandaniker.com/blog/
	 */
    public class SWFCapabilities
    {		
        private static var hasDeterminedDebugStatus:Boolean = false;
		
        public static function get isDebug():Boolean
        {
            if(!hasDeterminedDebugStatus)
            {
                try
                {
                    throw new Error();
                }
                catch(e:Error)
                {
                    var stackTrace:String = e.getStackTrace();
                    _isDebug = (stackTrace != null) && (stackTrace.indexOf("[") != -1);
                    hasDeterminedDebugStatus = true;
                    return _isDebug;
                }
            }
            return _isDebug;
        }
        private static var _isDebug:Boolean;
    }
}