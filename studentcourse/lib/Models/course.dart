class Course {
  final String id;
  final String courseName;
  final String courseInstrutor;
  final String courseCredits;

  Course(this.id, this.courseName, this.courseInstrutor, this.courseCredits);

  factory Course.fromJson(Map json) {
    final id = json[''].replaceAll('ObjectId(\")', '');
    final courseName = json['courseName'];
    final courseInstructor = json['courseInstructor'];
    final courseCredits = json['courseCredits'];

    return Course(id, courseName, courseInstructor, courseCredits);
  }
}
