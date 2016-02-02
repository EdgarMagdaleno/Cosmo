class Cosmo {
	public var subjects:Map<String, Subject>;

	public static function main():Void {
		new Cosmo();
	}

	public function new():Void {
		subjects = new Map<String, Subject>();
		getObjects();
		getArguments();
	}

	public function getObjects():Void {
		var tmp;
		for (filename in sys.FileSystem.readDirectory("subjects")) {
			tmp = haxe.Json.parse(sys.io.File.getContent("subjects/" + filename));
			subjects.set(filename.split(".txt")[0], new Subject(filename.split(".txt")[0], tmp.professor));
		}
	}

	public function getArguments():Void {
		for ( i  in 0 ... Sys.args().length )
			switch (Sys.args()[i]) {
				case "add": add(i);
				case "list": list(i);
				case "new": newFunction(i);
			}
	}

	public function add(i:Int):Void {
		switch (Sys.args()[i + 1]) {
			case "subject":
				if ( !sys.FileSystem.exists("subjects/" + Sys.args()[i + 2] + ".txt" )) {
					subjects.set(Sys.args()[i + 2], new Subject(Sys.args()[i + 2], In.readLine("Professor name: ")));
					sys.io.File.write("subjects/" + Sys.args()[i + 2] + ".txt").writeString(haxe.Json.stringify(subjects.get(Sys.args()[i + 2])));
				} else throw("Subject name already exists.");
			default: throw("Invalid syntax.");
		}
	}

	public function newFunction(i:Int):Void {
		if ( subjects.exists(Sys.args()[i + 1]) ) {
			switch ( Sys.args()[i + 2] ) {
				case "work": subjects.get(Sys.args()[i + 1]).work.push(new Work(In.readLine("Content: "), Date.fromString(In.readLine("Deadline: "))));
			}
			update();
		}
		else throw("Subject does not exist.");
	}

	public function list(i:Int):Void {
		if ( subjects.exists(Sys.args()[i + 1]) )
			switch ( Sys.args()[i + 2] ) {
				case "work": Sys.println(subjects.get(Sys.args()[i + 1]).work);
				default: throw("Option not recognized.");
			}
		else throw("Subject does not exist.");
	}

	public function exists(name:String):Bool {
		if ( sys.FileSystem.exists("subjects/" + name + ".txt") ) return true;
		return false;
	}

	public function update():Void {
		for ( subject in subjects )
			sys.io.File.write("subjects/" + subject.name + ".txt").writeString(haxe.Json.stringify(subject));
	}
}