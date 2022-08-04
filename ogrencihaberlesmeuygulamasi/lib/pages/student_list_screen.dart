import 'package:flutter/material.dart';
import 'package:studentapp/repostory/student_repo.dart';

class StudentListPage extends StatefulWidget{
  StudentRepo studentRepo;

  StudentListPage(this.studentRepo);

  @override
  State<StudentListPage> createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
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
                        child:   Text("${widget.studentRepo.student.length} Student"),
                                    ),
            Expanded(
              child: ListView.separated(itemBuilder:(context, index) => StudentRow(
                widget.studentRepo.student[index],
                  widget.studentRepo
              ),
                separatorBuilder: (context, index) => Divider(),
                itemCount: widget.studentRepo.student.length,


              ),
            )






          ],
        ),
      ),
    );

  }
}

class StudentRow extends StatefulWidget {
  Student student;
  StudentRepo studentRepo;

  StudentRow(this.student,this.studentRepo, {Key? key}) : super(key: key);

  @override
  State<StudentRow> createState() => _StudentRowState();
}

class _StudentRowState extends State<StudentRow> {
  @override
  Widget build(BuildContext context) {
    bool liked = widget.studentRepo.isLiked(widget.student);
    return ListTile(
      leading: IntrinsicWidth(child: Center(child: Text(widget.student.gender == "Kadın" ? "🙎🏻‍♀" : "🙎🏻‍♂"))),
      title: Text(widget.student.name + " " + widget.student.surname,),
      trailing: IconButton(onPressed: (){
        setState(() {

        widget.studentRepo.like(widget.student, !liked  );
        });



      },
          icon: Icon(liked ? Icons.favorite: Icons.favorite_border,
                      color:liked ? Colors.red: Colors.grey ,

           )
      ),

    );
  }
}