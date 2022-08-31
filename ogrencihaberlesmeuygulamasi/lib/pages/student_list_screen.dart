import 'package:flutter/material.dart';
import 'package:studentapp/repostory/student_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studentapp/models/student.dart';


class StudentListPage extends ConsumerWidget{


  const StudentListPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {


    var studentRepo = ref.watch(studentProvider);
    return Scaffold(
      appBar: AppBar(),

      body: Center(


        child: Column(


          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

                       Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32.0,horizontal: 32.0),
                        child:   Text("${studentRepo.student.length} Student"),
                                    ),
            Expanded(
              child: ListView.separated(itemBuilder:(context, index) => StudentRow(
                studentRepo.student[index],

              ),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: studentRepo.student.length,


              ),
            )






          ],
        ),
      ),
    );

  }
}

class StudentRow extends ConsumerWidget {
  Student student;


  StudentRow(this.student, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var studentRepo = ref.watch(studentProvider);
    bool liked = studentRepo.isLiked(student);
    return ListTile(
      leading: IntrinsicWidth(child: Center(child: Text(student.gender == "Kadın" ? "🙎🏻‍♀" : "🙎🏻‍♂"))),
      title: Text(student.name + " " + student.surname,),
      trailing: IconButton(
          onPressed: (){


        ref.read(studentProvider).like(student, !liked  );




      },
          icon: Icon(liked ? Icons.favorite: Icons.favorite_border,
                      color:liked ? Colors.red: Colors.grey ,

           )
      ),

    );
  }
}