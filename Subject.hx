class Subject {
	public var name:String;
	public var proffessor:String;
	public var email:String;
	public var work:String;

	public function new(subjectName:String, ?proffessorName = "Not known",?professorEmail:String = "Not known", 
		?subjectWork = "None"):Void {

		name = subjectName;
		proffessor = proffessorName;
		email = professorEmail;
		work = subjectWork;
	}
}