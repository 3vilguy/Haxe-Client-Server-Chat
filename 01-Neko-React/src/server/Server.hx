package server;

import neko.net.WebSocketServerLoop;
import neko.net.WebSocketServerLoop.ClientData;
import sys.net.Host;
import sys.net.Socket;

class Server 
{
	private static var HOST : String = "127.0.0.1";
	private static var PORT : Int = 1234;

	private var _serverLoop:WebSocketServerLoop<ClientData>;

	static function main()
	{
		new Server();
	}

	public function new() 
	{
		_serverLoop = new WebSocketServerLoop<ClientData>( function(socket:Socket) return new ClientData(socket) );
		_serverLoop.processIncomingMessage = handleIncomingMessage;
		try
		{
			_serverLoop.run(new Host(HOST), PORT);
		}
		catch (err:Dynamic)
		{
			Lib.println("Something went wrong:");
			Lib.println(err);
		}
	}

	private function handleIncomingMessage( connection : ClientData, message : String )
	{
		trace("Incoming: " + message);
		broadcastMessage(message);
	}
	
	private function broadcastMessage( message : String ) 
	{
		for (client in _serverLoop.clients)
		{
			client.ws.send(message);
		}
	}
}