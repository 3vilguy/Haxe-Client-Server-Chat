package view;

import haxe.Json;
import js.html.WebSocket;
import react.ReactComponent;
import react.ReactMacro.jsx;
import react.native.api.*;
import react.native.component.*;
import shared.Message;
import shared.MsgConsts;
import view.LoginView;
import view.common.Button;

class MainView extends ReactComponent
{
	private static var PORT : Int = 1234;
	private var _ws : WebSocket;

	static var styles = Main.styles;

	public function new(props)
	{
		super(props);
		state = {
			isConnected: false,
			name: "",
			messages: [],
			message: ""
		};
	}
	
	override function render()
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
				<View>
					<View>
					<$ChatView messages=${state.messages} />
						<TextInput
							style={styles.inputText}
							onChangeText=$onMessageChange
							value={state.message}
						/>
						<Button
							text="Send"
							onPress=$sendTextFromInputField
						/>
					</View>
				</View>
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
			sayHi(name);
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

	private function sayHi(name : String):Void
	{
		var introMsg:Message = { type: MsgConsts.INTRODUCTION_MSG, name: name };
		sendMessage( Json.stringify(introMsg) );
	}

	private function onMessageChange(text:String)
	{
		setState({ message: text });
	}


	private function sendTextFromInputField():Void
	{
		var text:String = state.message;
		if (text.length > 0) 
		{
			trace('Text => $text');
			var txtMsg:Message = { type: MsgConsts.TEXT_MSG, text: text };
			sendMessage( Json.stringify(txtMsg) );
			setState({ message: "" });
		}
	}


	private function sendMessage( msg : String ):Void
	{
		trace('Sending => $msg');
		_ws.send(msg);
	}
}