import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:studentapp/pages/student_list_screen.dart';
import 'package:studentapp/pages/teacher_list_screen.dart';
import 'package:studentapp/repostory/student_repo.dart';
import 'package:studentapp/repostory/teacher_repo.dart';
import 'package:studentapp/utilities/google_sign_in.dart';
import '../repostory/account.dart';
import '../repostory/message_repo.dart';
import 'main.dart';
import 'message_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'student_list_screen.dart';
import 'teacher_list_screen.dart';



class MainPage extends ConsumerWidget {
  const MainPage({Key? key, required this.account }) : super(key: key);

  final Account account;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
   final studentRepo = ref.watch(studentProvider);
   final teacherRepo = ref.watch(teacherProvider);

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(FirebaseAuth.instance.currentUser!.displayName!),
            ),
            ListTile(
              title: const Text("Student List"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return const StudentListPage();
                }));
              },
            ),
            ListTile(
              title: const Text("Teacher List"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return TeacherListpage(teacherRepo);
                }));
              },
            ),
            ListTile(
              title: const Text("Message"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return MessagePage();
                }));
              },
            ),
            ListTile(
              title: const Text("Logout"),
              onTap: () {
                signOutWithGoogle();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                  return LogInPage();
                }));
              },
            ),
          ],
        ),


      ),

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
                child: Text("${teacherRepo.teachers.length} Teacher")
            ),





          ],
        ),
      ),
    );
  }
}