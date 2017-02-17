package;

import neko.Lib;
import sys.net.Host;
import sys.net.Socket;

class Client
{
	public static function main()
	{
		//test();
		//one();
		two();
	}


	/**
	 * The example one
	 */
	public static function test()
	{
		Lib.println("opening connection");
		var sock = new Socket();
		sock.connect(new Host("localhost"), 1234);

		Lib.println("sending messages");
		sock.write("this is a test.");            Sys.sleep(.1);
		sock.write("this is another test.");      Sys.sleep(.1);
		sock.write("this is a third test.");      Sys.sleep(.1);
		sock.write("this is the last test.");

		sock.close();
		Lib.println("client done");
	}


	public static function one()
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


	public static function two()
	{
		Lib.println("opening connection");
		var sock = new Socket();
		sock.connect(new Host("localhost"), 1234);

        while( true ) {
            var l = sock.input.readLine();
            trace(l);
            if( l == "exit" ) {
                sock.close();
                break;
            }
        }
	}


	/**
	 * Using getChar
	 * Tricky because of all special keys
	 */
	public static function tmp()
	{
		Lib.println("opening connection");
		var sock = new Socket();
		sock.connect(new Host("localhost"), 1234);

		Lib.println("sending messages");
		
		var cout = Sys.stdout();
		var cin = Sys.stdin();
		var msg:String = "";

		while (true)
		{
			//cout.writeString('Hello!\n');
			//cout.writeString("Hello " + tmp);
			//sock.write(tmp + ".");
			
			
			//var tmp = cin.readLine();
			//Sys.print(tmp + Sys.);
			var c:Int = Sys.getChar(false);
			Lib.println(c);
			
			if (c >= 32 && c < 127)	 		// Symbols
			{
				var s:String = String.fromCharCode(c);
				Sys.println(s);
				Sys.println("");
				msg += s;
			}
			else if (c == 10 || c == 13)	// ENTER
			{
				if (msg != "")
				{
					sock.write(msg + "\n");
					Sys.sleep(0.1);
					msg = "";
				}
			}
			else if (c == 3 || c == 27)		// Ctrl + C or ESC
			{
				break;
			}
			else
			{
				// Whatever
				Sys.println("Ignore");
			}
		}
		//sock.write("test\n.");            Sys.sleep(1);
		//sock.write("test.");      Sys.sleep(1);
		//sock.write("test.\n");      Sys.sleep(1);
		//sock.write("this is the last test.");

		sock.close();
		Lib.println("client done");
		/*for (i in 0...15)
		{
			trace(String.fromCharCode(i));
		}*/
	}
}