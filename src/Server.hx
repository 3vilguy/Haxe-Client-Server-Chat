package;

import haxe.io.Bytes;
import neko.Lib;
import neko.net.ThreadServer;
import sys.net.Host;
import sys.net.Socket;

typedef Client = {
	var id: Int;
	var socket: Socket;
}

typedef ClientInfo = {
	var host: Host;
	var port: Int;
}

typedef Message = {
	var str: String;
}

class Server extends ThreadServer<Client, Message>
{
	private static var HOST : String = "localhost";
	private static var PORT : Int = 1234;

	private var _clientID : Int = 0;
	private var _clients : Array<Client> = [];

	public static function main()
	{
		var server = new Server();
		try
		{
			server.run(HOST, PORT);
		}
		catch (err:Dynamic)
		{
			Lib.println("Something went wrong:");
			Lib.println(err);
		}
	}


	override function init() {
		super.init();
		Lib.println("ษออออออออออออออออป");
		Lib.println("บ SERVER STARTED บ");
		Lib.println("ศออออออออออออออออผ");
	}


	override function clientConnected( s : Socket ) : Client
	{
		_clientID++;
		var clientInfo:ClientInfo = s.peer();
		Lib.println('Client #$_clientID connected - ${clientInfo.host}:${clientInfo.port}');
		var client:Client = { id: _clientID, socket: s };
		_clients.push(client);
		return client;
	}

	override function clientDisconnected( c : Client )
	{
		Lib.println('Client #${c.id} disconnected');
		_clients.remove(c);
	}

	override function readClientMessage( c : Client, buf : haxe.io.Bytes, pos : Int, len : Int ) : { msg : Message, bytes : Int }
	{
		// find out if there's a full message, and if so, how long it is.
		var complete = false;
		var cpos = pos;
		while (cpos < (pos+len) && !complete)
		{
			//check for a ENTER to signify a complete message
			complete = (buf.get(cpos) == 10 || buf.get(cpos) == 13);
			cpos++;
		}

		// no full message
		if( !complete ) return null;

		// got a full message, return it
		var msg:String = buf.getString(pos, cpos - 1 - pos);	// -1 so we can skip \n
		return {msg: {str: msg}, bytes: cpos-pos};
	}

	override function clientMessage( c : Client, msg : Message )
	{
		var message:String = '<${c.id}>${msg.str}';
		Lib.println(message);
		sendToClients(message, c.id);
	}
	
	
	private function sendToClients( msg : String, ?skip : Int = -1)
	{
		for (client in _clients)
		{
			if (client.id != skip) {
				sendData(client.socket, msg + "\n");
			}
		}
	}
}