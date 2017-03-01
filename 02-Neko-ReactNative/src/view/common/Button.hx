package view.common;

import react.ReactComponent;
import react.ReactMacro.jsx;
import react.native.api.*;
import react.native.component.*;

class Button extends ReactComponent
{
	private static var styles = StyleSheet.create({
		button: {
			alignSelf: 'center',
			justifyContent: 'center',
			alignItems: 'center',
			borderWidth: 1,
			borderColor: '#000000',
			margin: 15,
			padding: 5,
			borderRadius: 6
		},
		buttonText: {
			fontSize: 20,
			margin: 5,
		}
	});

	override function render()
	{
		return jsx('
			<TouchableHighlight
				style={[styles.button, {opacity: this.props.disabled ? 0.5 : 1}]}
				underlayColor="#CCCCCC"
				disabled={this.props.disabled}
				onPress={this.props.onPress}
			>
				<Text style={styles.buttonText}>
					{this.props.text}
				</Text>
			</TouchableHighlight>
		');
	}
}