import haxe.Json;
import sys.io.File;
import sys.FileSystem;

class Cosmo {
	public var subjects:Map<String, Subject>;
	public var args:Array<String>;
	public var monthDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

	public static function main():Void {
		new Cosmo();
	}

	public function new():Void {
		subjects = new Map<String, Subject>();
		args = Sys.args();
		getObjects();
		getArguments();
	}

	public function getObjects():Void {
		var tmp:Dynamic;
		for ( filename in FileSystem.readDirectory("subjects") ) {
			tmp = Json.parse(File.getContent("subjects/" + filename));
			subjects.set(tmp.name, new Subject(tmp.name, tmp.professor));

			for ( i in 0 ... tmp.works.length ){
				subjects.get(tmp.name).works.push(new Work(
					tmp.works[i].content,
					tmp.works[i].deadline));
			}
		}
	}

	public function getArguments():Void {
		for ( i  in 0 ... args.length )
			switch (args[i]) {
				case "add": add(i);
				case "list": list(i);
				case "new": newFunction(i);
			}
	}

	public function add(i:Int):Void {
		switch (args[i + 1]) {
			case "subject":
				if ( !FileSystem.exists("subjects/" + args[i + 2] + ".txt" )) {
					subjects.set(args[i + 2], new Subject(Sys.args()[i + 2], In.readLine("Professor name: ")));
					File.write("subjects/" + Sys.args()[i + 2] + ".txt").writeString(Json.stringify(subjects.get(Sys.args()[i + 2])));
				} else throw("Subject name already exists.");
			default: throw("Invalid syntax.");
		}
	}

	public function newFunction(i:Int):Void {
		if ( subjects.exists(args[i + 1]) ) {
			switch ( args[i + 2] ) {
				case "work": 
					subjects.get(args[i + 1]).works.push(new Work(In.readLine("Content: "), Date.fromString(In.readLine("Deadline: "))));
			}
			update();
		}
		else throw("Subject does not exist.");
	}

	public function list(i:Int):Void {
		if ( subjects.exists(args[i + 1]) ) {
			var subj:Subject = subjects.get(args[i + 1]);
			switch ( args[i + 2] ) {
				case "work":
					if ( subj.works.length != 0 ) 
						for ( i  in 0 ... subj.works.length )
							Sys.println("Work ["+(i+1)+"]: " + subj.works[i].content + ", " + getLeft(subj.works[i].deadline) + " days left");
					else Sys.println("No work");
				default: throw("Option not recognized.");
			}
		} else throw("Subject does not exist.");
	}

	public function getLeft(deadline:Date):Int {
		var dl:Date = Date.fromString(deadline.toString());
		return getDays(dl) - getDays(Date.now());
	}

	public function getDays(date:Date):Int {
		var days:Int = 0;
		for ( i in 0 ... date.getMonth()) days += monthDays[i];
		days += date.getDate();
		return days;
	}

	public function exists(name:String):Bool {
		if ( sys.FileSystem.exists("subjects/" + name + ".txt") ) return true;
		return false;
	}

	public function update():Void {
		for ( subject in subjects )
			File.write("subjects/" + subject.name + ".txt").writeString(Json.stringify(subject));
	}
}