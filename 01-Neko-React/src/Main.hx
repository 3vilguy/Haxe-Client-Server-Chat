package;

import js.Browser;
import react.ReactDOM;
import react.ReactMacro.jsx;

class Main 
{
	
	static function main() 
	{
		ReactDOM.render(jsx('<div/>'), Browser.document.getElementById('app'));
	}
}