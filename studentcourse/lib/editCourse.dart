import 'package:flutter/material.dart';
import 'package:studentcourse/api.dart';
import 'package:studentcourse/main.dart';
import 'editStudent.dart';

class EditCourse extends StatefulWidget {
  final String id, courseName, courseInstructor;
  final CourseApi api = CourseApi();

  EditCourse(this.id, this.courseName, this.courseInstructor);

  @override
  _EditCourseState createState() =>
      _EditCourseState(id, courseName, courseInstructor);
}

class _EditCourseState extends State<EditCourse> {
  final String id, courseName, courseInstructor;

  _EditCourseState(this.id, this.courseName, this.courseInstructor);

  List students = [];
  bool _dbLoaded = false;

  void initState() {
    super.initState();

    widget.api.getStudents().then((data) {
      setState(() {
        students = data;
        _dbLoaded = true;
      });
    });
  }

  void _deleteCourse(id, courseName) {
    setState(() {
      widget.api.editCourse(id, courseName);
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courseName),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  TextFormField(),
                  ElevatedButton(
                      onPressed: () => {
                            _deleteCourse(id, courseName),
                          },
                      child: Text("Delete Course")),
                ],
              ),
            ),
            Center(
                child: _dbLoaded
                    ? Column(
                        children: [
                          SizedBox(
                              height: 1000,
                              child: ListView(
                                shrinkWrap: true,
                                padding: EdgeInsets.all(15.0),
                                children: [
                                  ...students
                                      .map<Widget>(
                                        (students) => Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15),
                                          child: TextButton(
                                            onPressed: () => {
                                              Navigator.pop(context),
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditStudent(
                                                              students['_id'],
                                                              students['fname'],
                                                              students[
                                                                  'lname']))),
                                            },
                                            child: ListTile(
                                              leading: CircleAvatar(
                                                backgroundColor: Colors.red,
                                                child: Text(students['fname']),
                                              ),
                                              title: Text(
                                                students['lname'],
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ],
                              )),
                        ],
                      )
                    : Column(
                        children: <Widget>[
                          Text(
                            "Database Loading",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          CircularProgressIndicator()
                        ],
                      )),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.home),
          onPressed: () => {
                Navigator.pop(context),
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyHomePage())),
              }),
    );
  }
}
