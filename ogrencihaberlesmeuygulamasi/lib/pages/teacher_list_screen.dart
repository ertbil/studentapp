import 'package:flutter/material.dart';
import 'package:studentapp/repostory/teacher_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeacherListpage extends ConsumerWidget{
  TeacherRepo teacherRepo;

  TeacherListpage(this.teacherRepo);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final  teacherRepo = ref.watch(teacherProvider);
    return Scaffold(
      appBar: AppBar(),

      body: Center(


        child: Column(


          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Padding(
              padding: EdgeInsets.symmetric(vertical: 32.0,horizontal: 32.0),
              child:   Text("${teacherRepo.teacher.length} Student"),
            ),
            Expanded(
              child: ListView.separated(itemBuilder:(context, index) => StudentRow(
                 teacherRepo.teacher[index],

              ),
                separatorBuilder: (context, index) => Divider(),
                itemCount: teacherRepo.teacher.length,


              ),
            )






          ],
        ),
      ),
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