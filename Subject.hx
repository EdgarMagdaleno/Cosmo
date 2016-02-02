class Subject {
	public var name:String;
	public var proffessor:String;
	public var email:String;
	public var work:Array<Work>;

	public function new(subjectName:String, ?proffessorName = "Not known"):Void {
		name = subjectName;
		proffessor = proffessorName;
		work = new Array<Work>();
	}
}