package view;

import js.html.WebSocket;
import react.ReactComponent;
import react.ReactMacro.jsx;

class MainView extends ReactComponent
{
	private static var HOST_DEFAULT : String = "127.0.0.1";
	private static var PORT : Int = 1234;

	public function new(props:Dynamic) 
	{
		super(props);
	}

	override public function componentDidMount():Void 
	{
		setupSocketConnection();
	}

	override public function render():ReactElement 
	{
		return jsx('
			<div>
				OH HAI!
			</div>
		');
	}


	function setupSocketConnection():Void
	{
		var ws:WebSocket = new WebSocket('ws://$HOST_DEFAULT:$PORT'); // use native js WebSocket class (js.html.WebSocket in haxe)
		ws.onopen = function()
		{
			trace("CONNECT");
			ws.send("TestString");
		};
		ws.onmessage = function(e)
		{
			trace("RECEIVE: " + e.data);
		};
		ws.onclose = function()
		{
			trace("DISCONNECT");
		};
	}
}