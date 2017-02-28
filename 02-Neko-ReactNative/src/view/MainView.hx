package view;

import react.ReactComponent;
import react.ReactMacro.jsx;
import react.native.api.*;
import react.native.component.*;
import view.LoginView;

class MainView extends ReactComponent {
	static var styles = Main.styles;
	
	function new(props) {
		super(props);
		state = {
			name: "",
			messages: []
		};
	}
	
	override function render() {
		// Show login component
		return jsx('
			<$LoginView connectHandler=${connectToServer} />
		');
	}


	private function connectToServer( host : String, name : String ):Void
	{
		trace('connectToServer');
		trace(host, name);
	}
}