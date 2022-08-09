import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:studentapp/repostory/teacher_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studentapp/models/teacher.dart';
import 'package:studentapp/services/data_service.dart';

class TeacherListpage extends ConsumerWidget{
  TeacherRepo teacherRepo;

  TeacherListpage(this.teacherRepo);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final  teacherRepo = ref.watch(teacherProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          const TeacherDownloadButton()
        ],
      ),

      body: Center(


        child: Column(


          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0,horizontal: 32.0),
              child:   Text("${teacherRepo.teachers.length} teacher"),
            ),
            Expanded(
              child: ListView.separated(itemBuilder:(context, index) => StudentRow(
                 teacherRepo.teachers[index],

              ),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: teacherRepo.teachers.length,


              ),
            )






          ],
        ),
      ),
    );

  }
}

class TeacherDownloadButton extends StatefulWidget {


  const TeacherDownloadButton({
    Key? key,
  }) : super(key: key);

  @override
  State<TeacherDownloadButton> createState() => _TeacherDownloadButtonState();
}

class _TeacherDownloadButtonState extends State<TeacherDownloadButton> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context,ref,child) {
        return isLoading ? const CircularProgressIndicator(color: Colors.white,) : IconButton(onPressed: () async {

          //TODO loading
          //TODO error
                try{
                  setState(() {
                    isLoading = true;
                  });
                  await ref.read(teacherProvider).download();

                }catch(e){
                  Fluttertoast.showToast(msg: "Something went wrong ${e.toString()}", backgroundColor: const Color.fromRGBO(66, 66, 66, 100), textColor: Colors.white);
                }
                finally{


                  setState(() {
                    isLoading = false;

                  });}

        }, icon: const Icon(Icons.person_add));
      }
    );
  }
}

class StudentRow extends ConsumerWidget {
  Teacher teacher;


  StudentRow(this.teacher, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {


    return ListTile(
      leading: IntrinsicWidth(child: Center(child: Text(teacher.gender == "Kadın" ? "🙎🏻‍♀" : "🙎🏻‍♂"))),
      title: Text(teacher.name + " " + teacher.surname,),


    );
  }
}