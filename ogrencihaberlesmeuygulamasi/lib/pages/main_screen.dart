import 'package:flutter/material.dart';
import 'package:studentapp/pages/student_list_screen.dart';
import 'package:studentapp/pages/teacher_list_screen.dart';
import 'package:studentapp/repostory/student_repo.dart';
import 'package:studentapp/repostory/teacher_repo.dart';
import '../repostory/account.dart';
import '../repostory/message_repo.dart';
import 'message_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerWidget {
  MainPage({Key? key, required this.account }) : super(key: key);

  Account account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   final studentRepo = ref.watch(studentProvider);
   final teacherRepo = ref.watch(teacherProvider);

    return Scaffold(

      body: Center(


        child: Column(


          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(onPressed: () async {
             await Navigator.of(context).push(MaterialPageRoute(builder: (context){
                return MessagePage();
              }));


            },
                child: Text("${ref.watch(newMessageCountProvider)} New messages")
            ),
            TextButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                return const StudentListPage();
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