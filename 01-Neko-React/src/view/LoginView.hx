package view;

import react.ReactComponent;
import react.ReactMacro.jsx;

class LoginView extends ReactComponentOfProps<LoginViewProps>
{
	private static var HOST_DEFAULT : String = "127.0.0.1";


	public function new(props:LoginViewProps) 
	{
		super(props);
		
		state = { btnEnabled: true };
	}

	override public function render():ReactElement 
	{
		return jsx('
			< div style = {{height: "100vh", display: "flex", flexDirection: "column", justifyContent: "center", alignItems: "center"}} >
				<div style={{marginBottom: 10}}>
					<div>
						Server IP:
					</div>
					<div>
						<input ref="address" defaultValue=$HOST_DEFAULT />
					</div>
				</div>

				<div style={{marginBottom: 20}}>
					<div>
						Name:
					</div>
					<div>
						<input ref="name" defaultValue=${Date.now().getTime()} />
					</div>
				</div>

				<div>
					<button disabled=${!state.btnEnabled} onClick=$handleOnClick><b>Connect!</b></button>
				</div>
			</div>
		');
	}

	private function handleOnClick()
	{
		setState({ btnEnabled: false });
		props.connectHandler(refs.address.value, refs.name.value);
	}
}

typedef LoginViewProps = {
	?connectHandler : String -> String -> Void
}