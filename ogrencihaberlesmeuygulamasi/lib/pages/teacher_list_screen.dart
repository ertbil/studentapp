import 'package:flutter/material.dart';
import 'package:studentapp/repostory/student_repo.dart';
import 'package:studentapp/repostory/teacher_repo.dart';

class TeacherListpage extends StatefulWidget{
  TeacherRepo teacherRepo;

  TeacherListpage(this.teacherRepo);

  @override
  State<TeacherListpage> createState() => _TeacherListpageState();
}

class _TeacherListpageState extends State<TeacherListpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: Center(


        child: Column(


          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Padding(
              padding: EdgeInsets.symmetric(vertical: 32.0,horizontal: 32.0),
              child:   Text("${widget.teacherRepo.teacher.length} Student"),
            ),
            Expanded(
              child: ListView.separated(itemBuilder:(context, index) => StudentRow(
                  widget.teacherRepo.teacher[index],
                  widget.teacherRepo
              ),
                separatorBuilder: (context, index) => Divider(),
                itemCount: widget.teacherRepo.teacher.length,


              ),
            )






          ],
        ),
      ),
    );

  }
}

class StudentRow extends StatefulWidget {
  Teacher teacher;
  TeacherRepo teacherRepo;

  StudentRow(this.teacher,this.teacherRepo, {Key? key}) : super(key: key);

  @override
  State<StudentRow> createState() => _StudentRowState();
}

class _StudentRowState extends State<StudentRow> {
  @override
  Widget build(BuildContext context) {

    return ListTile(
      leading: IntrinsicWidth(child: Center(child: Text(widget.teacher.gender == "Kadın" ? "🙎🏻‍♀" : "🙎🏻‍♂"))),
      title: Text(widget.teacher.name + " " + widget.teacher.surname,),


    );
  }
}