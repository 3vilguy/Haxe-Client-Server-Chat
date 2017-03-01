package view;

import react.ReactComponent;
import react.ReactMacro.jsx;
import react.native.api.*;
import react.native.component.*;
import view.common.Button;

class LoginView extends ReactComponent
{
	private static var HOST_DEFAULT : String = "127.0.0.1";
	static var styles = Main.styles;
	
	public function new(props) 
	{
		super(props);
		
		state = {
			address: HOST_DEFAULT,
			name: "" + Date.now().getTime(),
			btnEnabled: true
		};
	}

	override function render()
	{
		return jsx('
			<View style={styles.container}>
				<Text>
					Server IP:
				</Text>
				<TextInput
					ref="address"
					style={styles.inputText}
					onChangeText=$onAddressChange
					value={this.state.address}
				/>
				
				<Text>
					Name:
				</Text>
				<TextInput
					ref="name"
					style={styles.inputText}
					onChangeText=$onNameChange
					value={this.state.name}
				/>

				<Button
					text="Connect!"
					disabled=${!state.btnEnabled}
					onPress=$handleOnClick
				>
				</Button>
			</View>
		');
	}

	private function onAddressChange(text:String)
	{
		setState({ address: text });
	}

	private function onNameChange(text:String)
	{
		setState({ name: text });
	}

	private function handleOnClick()
	{
		setState({ btnEnabled: false });
		props.connectHandler(state.address, state.name);
	}
}