import 'package:studentapp/Accounts/account.dart';
import 'package:flutter/material.dart';
import 'package:studentapp/register_page.dart';
import 'package:studentapp/student_list_screen.dart';
import 'package:studentapp/teacher_list_screen.dart';

import 'message_screen.dart';





class MainPage extends StatelessWidget {
  MainPage({Key? key, required this.account }) : super(key: key);

  Account account;



  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(


        child: Column(


          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                return MessagePage();
              }));

            },
                child: Text("10 New messages")
            ),
            TextButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                return StudentListPage();
              }));

            },
                child: Text("10 Students")
            ),
            TextButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context){
                return TeacherListpage();
              }));
            },
                child: Text("10 Teacher")
            ),





          ],
        ),
      ),
    );
  }
}