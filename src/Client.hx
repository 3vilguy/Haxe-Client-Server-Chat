package;

import sys.net.Host;
import sys.net.Socket;

class Client
{
	static function main() 
	{
		var s:Socket = new Socket();
		s.connect(new Host("localhost"), 5000);
		
		while ( true )
		{
			var l = s.input.readLine();
			trace(l);
			
			if ( l == "exit" )
			{
				s.close();
				break;
			}
		}
	}
}