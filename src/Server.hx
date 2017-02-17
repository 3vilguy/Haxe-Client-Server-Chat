package;

import haxe.io.Bytes;
import neko.Lib;
import neko.net.ThreadServer;
import sys.net.Socket;

typedef Client = {
	var id : Int;
}

typedef Message = {
	var str : String;
}

class Server extends ThreadServer<Client, Message>
{
	private static var HOST : String = "localhost";
	private static var PORT : Int = 1234;
	
	private var _clients:Array<Client> = [];

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
	
	// create a Client
	override function clientConnected( s : Socket ) : Client
	{
		var num = Std.random(100);
		Lib.println("client " + num + " is " + s.peer());
		var client:Client = { id: num };
		_clients.push(client);
		return client;
	}

	override function clientDisconnected( c : Client )
	{
		Lib.println("client " + Std.string(c.id) + " disconnected");
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
		Lib.println(c.id + " sent: " + msg.str);
	}
}