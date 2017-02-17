package;

import neko.Lib;
import sys.net.Socket;
import neko.net.ThreadServer;
import haxe.io.Bytes;

typedef Client = {
	var id : Int;
}

typedef Message = {
	var str : String;
}

class Server extends ThreadServer<Client, Message>
{
	public static function main()
	{
		var server = new Server();
		server.run("localhost", 1234);
	}
	
	override function init() {
		super.init();
		Lib.println("浜様様様様様様様融");
		Lib.println("� SERVER STARTED �");
		Lib.println("藩様様様様様様様夕");
	}
	
	// create a Client
	override function clientConnected( s : Socket ) : Client
	{
		var num = Std.random(100);
		Lib.println("client " + num + " is " + s.peer());
		return { id: num };
	}

	override function clientDisconnected( c : Client )
	{
		Lib.println("client " + Std.string(c.id) + " disconnected");
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