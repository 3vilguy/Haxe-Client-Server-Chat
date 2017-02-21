package;

import neko.Lib;
import sys.net.Host;
import sys.net.Socket;

class Client
{
	private static var HOST_DEFAULT : String = "127.0.0.1";
	private static var PORT : Int = 1234;

	public static function main()
	{
		new Client();
	}

	public function new()
	{
		var cin = Sys.stdin();

		Lib.print('Server IP: ');
		var ip = cin.readLine();
		if (ip == '') ip = HOST_DEFAULT;

		Lib.println("Connecting...");
		var socket:Socket;
		try
		{
			socket = new Socket();
			socket.connect(new Host(ip), PORT);
			Lib.println('Connected to $ip:$PORT');
		}
		catch (z:Dynamic)
		{
			Lib.println('Could not connect to $ip:$PORT');
			return;
		}

		while (true)
		{
			var msg:String = cin.readLine();
			if (msg == "/exit")
			{
				break;
			}
			else if (msg == "")
			{
				// Do nothing :V
			}
			else
			{
				socket.write(msg + "\n");
				Sys.sleep(0.05);
			}
		}

		socket.close();
		Lib.println("client done");
	}
}