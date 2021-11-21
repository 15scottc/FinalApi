import 'package:flutter/material.dart';
import 'package:studentcourse/editCourse.dart';
import 'api.dart';
import 'editCourse.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Course App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final CourseApi api = CourseApi();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List courses = [];
  bool _dbLoaded = false;

  void initState() {
    super.initState();

    widget.api.getCourses().then((data) {
      setState(() {
        courses = data;
        _dbLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Course App"),
      ),
      body: Center(
          child: _dbLoaded
              ? Column(
                  children: [
                    Expanded(
                        child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(15.0),
                      children: [
                        ...courses
                            .map<Widget>(
                              (courses) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 30),
                                child: TextButton(
                                  onPressed: () => {
                                    Navigator.pop(context),
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => EditCourse(
                                                courses['_id'],
                                                courses['courseName'],
                                                courses['courseInstructor']))),
                                  },
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.red,
                                      child: Text(courses['courseInstructor']),
                                    ),
                                    title: Text(
                                      courses['courseName'],
                                      style: TextStyle(fontSize: 20),
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    CircularProgressIndicator()
                  ],
                )),
    );
  }
}
