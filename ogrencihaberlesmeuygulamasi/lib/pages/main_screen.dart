import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rive/rive.dart';
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
import 'package:lottie/lottie.dart';

/*
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
  match /users/{userId}/{documents=**} {
      allow read, write: if request.auth != null && request.auth.uid == userId
    }
    match /teachers/{document=**} {
      allow read, write: if
          request.time < timestamp.date(2022, 9, 17);
    }
  }
}*/

/*

rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /ppics/{imagename} {
      allow read, write: if request.auth != null && imagename.matches(request.auth.uid +'.jpg');
    }
  }
}


*/

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
            const UserHeader(),
            ListTile(
              title: const Text("Student List"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return const StudentListPage();
                }));
              },
            ),
            ListTile(
              title: Hero(
                tag: "teacher",
                  child: Material(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),

                        child: const Text("Teacher List")
                    ),
                  )
              ),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return TeacherListpage(teacherRepo);
                }
                )
                );
              },
            ),
            ListTile(
              title: const Text("Message"),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                  return const MessagePage();
                }));
              },
            ),
            ListTile(
              title: const Text("Logout"),
              onTap: () {
                signOutWithGoogle();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
                  return const LogInPage();
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
            const SizedBox(
              width: 200,
              height: 200,
              child: RiveAnimation.asset(
                'assets/animations/running guy.riv',
                fit: BoxFit.cover,
              ),
            ),
             SizedBox(
              width: 200,
              height: 200,
              child: Lottie.asset('assets/animations/Person.zip'),
            ),

            TextButton(onPressed: () async {
             await Navigator.of(context).push(MaterialPageRoute(builder: (context){
                return const MessagePage();
              }
              ));
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

class UserHeader extends StatefulWidget {
  const UserHeader({
    Key? key,
  }) : super(key: key);

  @override
  State<UserHeader> createState() => _UserHeaderState();
}

class _UserHeaderState extends State<UserHeader> {

  Future<Uint8List?>? _ppicFut;

  @override
  void initState() {
    super.initState();
  _ppicFut= _ppicDownload();

  }
  Future<Uint8List?> _ppicDownload() async {

    final uid = FirebaseAuth.instance.currentUser!.uid;
    final documentSnapshot = await FirebaseFirestore.instance.collection("users").doc(uid).get();
    final userRecMap = documentSnapshot.data();
    if(userRecMap == null){
      return null;
    }
    if(userRecMap.containsKey("ppicref")){
          Uint8List? uint8list = await FirebaseStorage.instance.ref(userRecMap["ppicref"]).getData();
          return uint8list;
    }

  }


  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      decoration: const BoxDecoration(
        color: Colors.blue,
      ),
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          InkWell(
            onTap: () async {
            XFile? xfile =   await ImagePicker().pickImage(source: ImageSource.camera);
            if(xfile == null){
              return;
            }
            else{
              final imagepath = xfile.path;

              final uid = FirebaseAuth.instance.currentUser!.uid;

              final ppicref = FirebaseStorage.instance.ref("ppic").child("$uid.jpg");


              await ppicref.putFile(File(imagepath));

              await FirebaseFirestore.instance.collection("users").doc(uid).update({
                "ppicref": ppicref.fullPath,
              });
                setState(() {
                  _ppicFut = _ppicDownload();
                });
              }

              },
            child: FutureBuilder<Uint8List?>(
              future: _ppicFut,
              builder: (context, snapshot) {

                if(snapshot.hasData && snapshot.data != null){
                  final picInMemory = snapshot.data!;
                  return  MovingAvatar(picInMemory: picInMemory);
                }
                else {
                    return CircleAvatar(
                      radius: 50,
                      child: Text(
                        FirebaseAuth.instance.currentUser!.displayName!
                            .characters.first,
                        style:
                            const TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    );
                  }
                }
            ),
          ),
          const SizedBox(height: 10,),
          Text(FirebaseAuth.instance.currentUser!.displayName!,style: const TextStyle(fontSize: 20,color: Colors.white),),
        ],
      ),
    );
  }


}

class MovingAvatar extends StatefulWidget {
  const MovingAvatar({
    Key? key,
    required this.picInMemory,
  }) : super(key: key);

  final Uint8List picInMemory;

  @override
  State<MovingAvatar> createState() => _MovingAvatarState();
}

class _MovingAvatarState extends State<MovingAvatar> with SingleTickerProviderStateMixin<MovingAvatar> {

  late Ticker _ticker;

  double horizantalPos = 0;

  @override
  void initState() {

    super.initState();
     _ticker  = createTicker((elapsed) {
       final angle  = pi * elapsed.inMicroseconds/const Duration(seconds: 1).inMicroseconds;
        setState(() {
            horizantalPos =  sin(angle)*30+30;
        });
     });
     _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left : horizantalPos),
      child: CircleAvatar(
        radius: 50,
        backgroundImage: MemoryImage(widget.picInMemory),
      ),
    );
  }
}