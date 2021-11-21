import 'package:dio/dio.dart';
import './Models/course.dart';
import './Models/student.dart';

const String localhost = "http://10.0.2.2:1200/";

class CourseApi {
  final _dio = Dio(BaseOptions(baseUrl: localhost));

  Future<List> getCourses() async {
    final response = await _dio.get('/getAllCourses');

    return response.data['courses'];
  }

  Future editCourse(String id, String courseName) async {
    final response = await _dio
        .post('/deleteCourseById', data: {'id': id, 'courseName': courseName});
  }

  Future<List> getStudents() async {
    final response = await _dio.get('/getAllStudents');
    return response.data['students'];
  }

  Future editStudent(String id, String fname) async {
    final response = await _dio
        .post('/editStudentByFname', data: {'id': id, 'fname': fname});
  }
}
