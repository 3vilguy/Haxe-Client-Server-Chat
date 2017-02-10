package;

import sys.net.Host;
import sys.net.Socket;

class Server
{
	static function main() 
	{
		var s:Socket = new Socket();
		s.bind(new Host("localhost"), 5000);
		s.listen(1);
		trace("Starting server...");

		while ( true )
		{
			var c : Socket = s.accept();
			trace("Client connected...");
			c.write("hello\n");
			c.write("your IP is " + c.peer().host.toString() + "\n");
			c.write("exit");
			c.close();
		}
	}
}