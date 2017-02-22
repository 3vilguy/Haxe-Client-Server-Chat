package view;

import react.ReactComponent;
import react.ReactMacro.jsx;

class MainView extends ReactComponent
{
	public function new(props:Dynamic) 
	{
		super(props);
	}
	
	override public function render():ReactElement 
	{
		return jsx('
			<div>
				OH HAI!
			</div>
		');
	}
}