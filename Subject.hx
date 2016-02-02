class Subject {
	public var name:String;
	public var proffessor:String;
	public var email:String;
	public var works:Array<Work>;

	public function new(subjectName:String, proffessorName):Void {
		name = subjectName;
		proffessor = proffessorName;
		works = new Array<Work>();
	}
}