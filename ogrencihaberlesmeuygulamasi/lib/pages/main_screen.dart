import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:studentapp/pages/student_list_screen.dart';

import 'package:studentapp/pages/teacher_list_screen.dart';
import 'package:studentapp/repostory/message_repo.dart';
import 'package:studentapp/repostory/student_repo.dart';
import 'package:studentapp/repostory/teacher_repo.dart';
import '../repostory/account.dart';
import 'message_screen.dart';





class MainPage extends StatefulWidget {
  MainPage({Key? key, required this.account }) : super(key: key);

  Account account;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  MessagesRepository messagesRepository = MessagesRepository();
  StudentRepo studentRepo = StudentRepo();
  TeacherRepo teacherRepo = TeacherRepo();
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(


        child: Column(


          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(onPressed: () async {
             await Navigator.of(context).push(MaterialPageRoute(builder: (context){
                return MessagePage(messagesRepository);
              }));
             setState(() {

             });

            },
                child: Text("${messagesRepository.newMessageCount} New messages")
            ),
            TextButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                return StudentListPage(studentRepo);
              }));

            },
                child: Text("${studentRepo.student.length} Students")
            ),
            TextButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                return TeacherListpage(teacherRepo);
              }));
            },
                child: Text("${teacherRepo.teacher.length} Teacher")
            ),





          ],
        ),
      ),
    );
  }
}