package view;

import js.html.WebSocket;
import react.ReactComponent;
import react.ReactMacro.jsx;

class MainView extends ReactComponent
{
	private static var HOST_DEFAULT : String = "127.0.0.1";
	private static var PORT : Int = 1234;

	private var _ws : WebSocket;

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
				<input ref="input" placeholder="Type text here" onKeyPress=$onKeyPress />
				<button onClick=$sendMessage>Send</button>
			<div/>
		');
	}


	function setupSocketConnection():Void
	{
		_ws = new WebSocket('ws://$HOST_DEFAULT:$PORT');
		_ws.onopen = function()
		{
			trace("CONNECT");
			_ws.send("TestString");
		};
		_ws.onmessage = function(e)
		{
			trace("RECEIVE: " + e.data);
		};
		_ws.onclose = function()
		{
			trace("DISCONNECT");
		};
	}

	function onKeyPress(e:Dynamic)
	{
		if (e.key == 'Enter')
		{
			sendMessage();
		}
	}


	function sendMessage()
	{
		var text:String = refs.input.value;
		if (text.length > 0) 
		{
			trace(text);
			_ws.send(text);
			refs.input.value = "";
		}
	}
}