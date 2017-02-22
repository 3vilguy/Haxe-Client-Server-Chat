package server;

import neko.net.WebSocketServerLoop;
import neko.net.WebSocketServerLoop.ClientData;
import sys.net.Host;
import sys.net.Socket;

class Server 
{
	private static var HOST : String = "127.0.0.1";
	private static var PORT : Int = 1234;

	static function main()
	{
		new Server();
	}

	public function new() 
	{
		var serverLoop:WebSocketServerLoop<ClientData> = new WebSocketServerLoop<ClientData>( function(socket:Socket) return new ClientData(socket) );
		serverLoop.processIncomingMessage = handleIncomingMessage;
		serverLoop.run(new Host(HOST), PORT);
	}

	private function handleIncomingMessage( connection : ClientData, message : String )
	{
		trace("Incoming: " + message);
	}
}