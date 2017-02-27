package server;

import haxe.Json;
import neko.Lib;
import neko.net.WebSocketServerLoop;
import neko.net.WebSocketServerLoop.ClientData;
import shared.Message;
import shared.MsgConsts;
import sys.net.Host;
import sys.net.Socket;

class Server 
{
	private static var HOST_DEFAULT : String = "127.0.0.1";
	private static var PORT : Int = 1234;

	private var _serverLoop:WebSocketServerLoop<MyClientData>;

	static function main()
	{
		new Server();
	}

	public function new() 
	{
		var cin = Sys.stdin();
		Lib.print('Server IP: ');
		var ip = cin.readLine();
		if (ip == '') ip = HOST_DEFAULT;

		_serverLoop = new WebSocketServerLoop<MyClientData>( function(socket:Socket) return new MyClientData(socket) );
		_serverLoop.processIncomingMessage = handleIncomingMessage;
		try
		{
			_serverLoop.run(new Host(ip), PORT);
		}
		catch (err:Dynamic)
		{
			Lib.println("Something went wrong:");
			Lib.println(err);
		}
	}

	private function handleIncomingMessage( connection : MyClientData, message : String )
	{
		Lib.println("Incoming: " + message);
		var msg:Message = Json.parse(message);
		switch(msg.type)
		{
			case MsgConsts.INTRODUCTION_MSG:
				connection.name = msg.name;
				broadcastMessage( '${msg.name} has joined.' );
			
			case MsgConsts.TEXT_MSG:
				broadcastMessage( '<${connection.name}>${msg.text}' );
			
			default:
				// What am I doing here?
				Lib.println('Message type [${msg.type}] is not supported.');
		}
	}
	
	private function broadcastMessage( message : String ) 
	{
		for (client in _serverLoop.clients)
		{
			client.ws.send(message);
		}
	}
}

class MyClientData extends ClientData
{
	public var name:String;
}