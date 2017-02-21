package;

import neko.Lib;
import sys.net.Host;
import sys.net.Socket;

class Client
{
	public static function main()
	{
		var cin = Sys.stdin();

		Lib.print('Server IP: ');
		var ip = cin.readLine();
		if (ip == '') ip = '127.0.0.1';

		Lib.println("Opening connection");
		var sock:Socket = new Socket();
		sock.connect(new Host(ip), 1234);
		

		while (true)
		{
			var msg:String = cin.readLine();
			if (msg == "/exit")
			{
				break;
			}
			else
			{
				sock.write(msg + "\n");
				Sys.sleep(0.05);
			}
		}

		sock.close();
		Lib.println("client done");
	}
}