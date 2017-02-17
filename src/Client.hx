package;

import neko.Lib;
import sys.net.Host;
import sys.net.Socket;

class Client
{
	public static function main()
	{
		Lib.println("opening connection");
		var sock:Socket = new Socket();
		sock.connect(new Host("localhost"), 1234);
		
		var cin = Sys.stdin();

		while (true)
		{
			sock.write(cin.readLine() + "\n");
			Sys.sleep(0.1);
		}

		sock.close();
		Lib.println("client done");
	}
}