class In {
	public static function readInt(message:Dynamic):Int {
		Sys.print(message);
		return Std.parseInt(Sys.stdin().readLine());
	}

	public static function readLine(message:Dynamic):String {
		Sys.print(message);
		return Sys.stdin().readLine();
	}
}