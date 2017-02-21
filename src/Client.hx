package;

import neko.Lib;
import neko.vm.Thread;
import sys.net.Host;
import sys.net.Socket;

class Client
{
	private static var HOST_DEFAULT : String = "127.0.0.1";
	private static var PORT : Int = 1234;
	
	private static var _socket:Socket;

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
		try
		{
			_socket = new Socket();
			_socket.connect(new Host(ip), PORT);
			Lib.println('Connected to $ip:$PORT');
		}
		catch (z:Dynamic)
		{
			Lib.println('Could not connect to $ip:$PORT');
			return;
		}
		
		// Start listening on separate Thread
		Thread.create(threadListen);

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
				_socket.write(msg + "\n");
				Sys.sleep(0.05);
			}
		}

		_socket.close();
		Lib.println("client done");
	}
	
	public function threadListen() {
		while (true) {
			try {
				var text = _socket.input.readLine();
				Lib.println(text);
			} catch (z:Dynamic) {
				Lib.println('Connection lost.');
				Sys.exit(0);
				return;
			}
		}
	}
}