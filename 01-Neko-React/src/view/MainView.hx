package view;

import js.html.WebSocket;
import react.ReactComponent;
import react.ReactMacro.jsx;

class MainView extends ReactComponentOfState<MainViewState>
{
	private static var PORT : Int = 1234;

	private var _ws : WebSocket;


	public function new(props:Dynamic) 
	{
		super(props);
		
		state = {
			isConnected: false,
			name: "",
			messages: []
		};
	}

	override public function render():ReactElement 
	{
		if (state.isConnected == false)
		{
			// Show login component
			return jsx('
				<$LoginView connectHandler=${connectToServer} />
			');
		}
		else
		{
			// Show chat component
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
	}


	private function connectToServer( host : String, name : String ):Void
	{
		_ws = new WebSocket('ws://$host:$PORT');
		_ws.onopen = function()
		{
			trace("CONNECT");
			setState({
				isConnected: true,
				name: name
			});
			_ws.send('$name has joined.');
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

	private function onKeyPress( e : Dynamic ):Void
	{
		if (e.key == 'Enter')
		{
			var text:String = refs.input.value;
			if (text.length > 0) 
			{
				sendMessage(text);
				refs.input.value = "";
			}
		}
	}


	private function sendMessage( msg : String ):Void
	{
		trace('Sending => $msg');
		_ws.send('<${state.name}>$msg');
	}
}

typedef MainViewState = {
	?isConnected : Bool,
	?name : String,
	?messages : Array<String>,
}