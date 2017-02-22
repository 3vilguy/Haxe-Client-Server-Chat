package;

import js.Browser;
import react.ReactDOM;
import react.ReactMacro.jsx;
import view.MainView;

class Main 
{
	
	static function main() 
	{
		ReactDOM.render(jsx('<MainView/>'), Browser.document.getElementById('app'));
	}
}