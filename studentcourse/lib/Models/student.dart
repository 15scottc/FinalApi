class Student {
  final String id;
  final String fname;
  final String lname;

  Student(this.id, this.fname, this.lname);

  factory Student.fromJson(Map json) {
    final id = json[''].replaceAll('ObjectId(\")', '');
    final fname = json['fname'];
    final lname = json['lname'];

    return Student(id, fname, lname);
  }
}
