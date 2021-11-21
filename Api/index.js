const express = require('express');
const app = express();
const nodemon = require('nodemon');
app.use(express.json());

//mongoDB Package
const mongoose = require('mongoose');

const PORT = 1200;

const dbUrl = 'mongodb+srv://Drickikcha:12345@cluster0.iwesf.mongodb.net/Project1?retryWrites=true&w=majority';

mongoose.connect(dbUrl,
    {
        useNewUrlParser: true,
        useUnifiedTopology: true
    })

//Mongo DB Connection

const db = mongoose.connection;

//handle DB Error, display connection

db.on('error', ()=>{
    console.error.bind(console,'connection error: ');
});

db.once('open', () => {
    console.log('MongoDB Connected');
});

//Schema/Model Declaration
require('./Models/studentObject');
require('./Models/courseObject');

const Student = mongoose.model('Student');
const Course = mongoose.model('Course');

app.get('/',(req,res) => {
    return res.status(200).json("(message: OK)");
});

app.post('/addCourse', async (req,res) => {
    try{
        let course = {
            courseInstructor: req.body.courseInstructor,
            courseCredits: req.body.courseCredits,
            courseID: req.body.courseID,
            courseName: req.body.courseName
        }
        await Course(course).save().then(c => {
            return res.status(201).json("Course Added");
        });
    }
    catch{
        return res.status(400).json("(message: Failed to Add Course - Bad Data)");
    }
});

app.get('/getAllCourses', async (req,res) => {
    try{
        let courses = await Course.find({}).lean();
        return res.status(200).json({"courses" : courses});
    }
    catch{
        return res.status(400).json("(message: Failed to Access Course Data)")
    }
});

app.get('/findCourse', async (req,res) => {
    try{
        let query = req.body.courseID;
        let courses = await Course.find({"courseID" : query});
        return res.status(200).json(courses);
    }
    catch{
        return res.status(400).json("(message: Failed to Access Course Data)")
    }
});

app.post('/addStudent', async (req,res) => {
    try{
        let student = {
            fname: req.body.fname,
            lname: req.body.lname,
            studentID: req.body.studentID
        }
        await Student(student).save().then(s => {
            return res.status(201).json("Student Added");
        });
    }
    catch {
        return res.status(400).json("(message: Failed to Add Student - Bad Data)");
    }
});

app.get('/getAllStudents', async (req,res) => {
    try{
        let students = await Student.find({}).lean();
        return res.status(200).json({"students" : students});
    }
    catch{
        return res.status(400).json("(message: Failed to Access Student Data)");
    }
});

app.get('/findStudent', async (req,res) => {
    try{
        let query = req.body.fname;
        let students = await Student.find({"fname" : query});
        return res.status(200).json(students);
    }
    catch{
        return res.status(400).json("(message: Failed to Access Student Data)");
    }
});

app.post('/editByStudentId', async (req,res)=>{
    try{
        let students = await Student.updateOne({_id: req.body.id}
            , {
                "fname": req.body.fname
            }, {upsert: true});
            if(students)
            {
                res.status(200).json("(Message: Student edited)");
            }
            else {
                res.status(200).json("(Message: No student changed");
            }
    }
    catch {
        return res.status(500).json("(Message: Failed to edit student");
    }
});

app.post('/editStudentByFname', async (req,res)=>{
    try{
        let students = await Student.updateOne({_id : req.body.id}
            , {
                "fname": req.body.fname,
            }, {upsert: true});
            if(students)
            {
                res.status(200).json("(Message: Student edited)");
            }
            else {
                res.status(200).json("(Message: No student changed)");
            }
    }
    catch {
        return res.status(500).json("(Message: Failed to edit student)");
    }
});

app.post('/editCourseByCourseName', async (req,res)=>{
    try{
        let courses = await Course.updateOne({courseName : req.body.courseName}
            , {
                "instructorName": req.body.instructorName,
            }, {upsert: true});
            if(courses)
            {
                res.status(200).json("(Message: Course edited)");
            }
            else {
                res.status(200).json("(Message: No course changed)");
            }
    }
    catch {
        return res.status(500).json("(Message: Failed to edit course)");
    }
});

app.post('/deleteCourseById', async (rec,res)=> {
    try {
        let course = await Course.findOne({_id: rec.body.id});

        if(course){
            await Course.deleteOne({_id: rec.body.id});
            return res.status(200).json("(Message: Course deleted)");
        }
        else {
            return res.status(200).json("(Message: No course deleted - query null)");
        }
    }
    catch {
        return res.status(500).json("(Message: Failed to delete course");
    }
});

app.post('/removeStudentFromClasses', async (rec,res)=> {
    try {
        let student = await Student.findOne({_id: rec.body.id});

        if(student){
            await Student.deleteOne({_id: rec.body.id});
            return res.status(200).json("(Message: Student deleted)");
        }
        else {
            return res.status(200).json("(Message: No Student deleted - query null)");
        }
    }
    catch {
        return res.status(500).json("(Message: Failed to delete student");
    }
});




app.listen(PORT, () => {
    console.log(`Server Started on Port ${PORT}`);
});
