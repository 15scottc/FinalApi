import 'package:flutter/material.dart';
import 'package:studentcourse/api.dart';
import 'package:studentcourse/main.dart';

class EditStudent extends StatefulWidget {
  final String id, fname, lname;
  final CourseApi api = CourseApi();

  EditStudent(this.id, this.fname, this.lname);

  @override
  _EditStudentState createState() => _EditStudentState(id, fname, lname);
}

class _EditStudentState extends State<EditStudent> {
  final String id, fname, lname;

  _EditStudentState(this.id, this.fname, this.lname);

  void _editStudent(id, fname) {
    setState(() {
      widget.api.editStudent(id, fname);
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    });
  }

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fname),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: textEditingController,
                  ),
                  ElevatedButton(
                      onPressed: () => {
                            _editStudent(widget.id, textEditingController.text),
                          },
                      child: Text("Change first name")),
                ],
              ),
            ),
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
