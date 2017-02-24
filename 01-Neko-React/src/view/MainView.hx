package view;

import js.html.WebSocket;
import react.ReactComponent;
import react.ReactMacro.jsx;

class MainView extends ReactComponentOfState<MainViewState>
{
	private static var HOST_DEFAULT : String = "127.0.0.1";
	private static var PORT : Int = 1234;

	private var _ws : WebSocket;

	public function new(props:Dynamic) 
	{
		super(props);
		
		state = { messages: [] };
	}

	override public function componentDidMount():Void 
	{
		setupSocketConnection();
	}

	override public function render():ReactElement 
	{
		return jsx('
			<div style={{height: "100vh", display: "flex", flexDirection: "column", justifyContent: "flex-end", backgroundColor: "#DDDDDD"}}>
				<$ChatView messages=${state.messages} />
				<div style = {{padding: 5, display: "flex"}}>
					<input ref="input" placeholder="Type text here" onKeyPress=$onKeyPress style={{flexGrow: 2}} />
					<button onClick=$sendMessage>Send</button>
				</div>
			<div/>
		');
	}


	private function setupSocketConnection():Void
	{
		_ws = new WebSocket('ws://$HOST_DEFAULT:$PORT');
		_ws.onopen = function()
		{
			trace("CONNECT");
		};
		_ws.onmessage = function(e)
		{
			trace("RECEIVE: " + e.data);
			var messages:Array<String> = state.messages;
			messages.push(e.data);
			setState({ messages: messages });
		};
		_ws.onclose = function()
		{
			trace("DISCONNECT");
		};
	}

	private function onKeyPress(e:Dynamic)
	{
		if (e.key == 'Enter')
		{
			sendMessage();
		}
	}


	private function sendMessage()
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

typedef MainViewState = {
	?messages : Array<String>
}