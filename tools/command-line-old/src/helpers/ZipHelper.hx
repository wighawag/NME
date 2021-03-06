package helpers;


import haxe.io.Bytes;
import haxe.io.Path;
import haxe.Int32;
import haxe.SHA1;
import neko.zip.Writer;
import sys.io.File;
import sys.FileSystem;


class ZipHelper {
	
	
	public static function compress (path:String):Void {
		
		var files = new Array <Dynamic> ();
		
		var directory = Path.directory (path);
		
		for (file in FileSystem.readDirectory (directory)) {
			
			if (Path.extension (file) != "zip" && Path.extension (file) != "crx" && Path.extension (file) != "wgt") {
				
				var name = file;
				//var date = FileSystem.stat (directory + "/" + file).ctime;
				var date = Date.now ();
				
				var input = File.read (directory + "/" + file, true);
				var data = input.readAll ();
				input.close ();
				
				files.push ( { fileName: name, fileTime: date, data: data } );
				
			}
			
		}
		
		var output = File.write (path, true);
		
		/*if (Path.extension (path) == "crx") {
			
			var input = File.read (defines.get ("KEY_STORE"), true);
			var publicKey:Bytes = input.readAll ();
			input.close ();
			
			var signature = SHA1.encode ("this isn't working");
			
			output.writeString ("Cr24"); // magic number
			output.writeInt32 (Int32.ofInt (2)); // CRX file format version
			output.writeInt32 (Int32.ofInt (publicKey.length)); // public key length
			output.writeInt32 (Int32.ofInt (signature.length)); // signature length
			output.writeBytes (publicKey, 0, publicKey.length);
			output.writeString (signature);
			
			//output.writeBytes (); // public key contents "The contents of the author's RSA public key, formatted as an X509 SubjectPublicKeyInfo block. "
			//output.writeBytes (); // "The signature of the ZIP content using the author's private key. The signature is created using the RSA algorithm with the SHA-1 hash function."
			
		}*/
		
		Writer.writeZip (output, files, 1);
		output.close ();
		
	}
		

}
