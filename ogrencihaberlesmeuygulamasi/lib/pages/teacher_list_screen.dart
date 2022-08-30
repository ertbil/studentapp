import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:studentapp/repostory/teacher_repo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studentapp/models/teacher.dart';
import 'package:studentapp/services/data_service.dart';


List<String> genders = ["Erkek","Kadın"];

class TeacherListpage extends ConsumerWidget{
  final TeacherRepo teacherRepo;


  const TeacherListpage(this.teacherRepo, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final  teacherRepo = ref.watch(teacherProvider);
    return Scaffold(
      floatingActionButton: const AddTeacher(),
      appBar: AppBar(
        actions: const [
          TeacherDownloadButton()
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
              child: RefreshIndicator(
                onRefresh: () async {
                  ref.refresh(teacherListProvider);
                },
                child: ref.watch(teacherListProvider).when(
                    data: (data) => ListView.separated(itemBuilder:(context, index) => TeacherRow(
                      data[index],

                    ),
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: data.length,


                    ),
                    error: (error, stackTrace) {
                      return const Text("Error!!!");

                    },
                    loading: () => const Center(child: CircularProgressIndicator(),),),
              )
            )

          ],
        ),
      ),
    );

  }
}

class AddTeacher extends ConsumerStatefulWidget {
  const AddTeacher({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<AddTeacher> createState() => _AddTeacherState();
}

class _AddTeacherState extends ConsumerState<AddTeacher> {

  String gender = "Erkek";
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  final Map<String, dynamic> inputs = {};
  final _formKey = GlobalKey<FormState>();

  bool isSaving = false;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),

      onPressed: () {
        showDialog<void>(
          context: context,
          barrierDismissible: false,
          // false = user must tap button, true = tap outside dialog
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: Row(
                children: const [
                  Icon(Icons.person_add),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Add new Teacher'),
                  ),
                ],
              ),

              actions: [

                Form(
                  key: _formKey,
                    child:Column (
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: nameController,

                          decoration: const InputDecoration(

                            hintText: "Name",

                          ),
                          validator: (value) {
                            if(value != null){

                              if(value.isEmpty){
                                return "This Place can not be empty";
                              }

                              else {
                                return null;
                              }
                            }
                          },
                          onSaved: (newValue) {
                            inputs['name'] = newValue;
                          },

                        ),
                        TextFormField(

                          decoration: const InputDecoration(

                            hintText: "Surname",

                          ),
                          validator: (value) {
                            if(value != null){

                              if(value.isEmpty){
                                return "This Place can not be empty";
                              }else {
                                return null;
                              }
                            }
                          },
                          onSaved: (newValue) {
                            inputs['surname'] = newValue;
                          },

                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,

                          children: [
                                  SizedBox(
                                    width: 140,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        keyboardType: TextInputType.phone,


                                        decoration: const InputDecoration(

                                          hintText: "Age",

                                        ),
                                        validator: (value) {
                                          if(value != null){

                                            if(value.isEmpty){
                                              return "This Place can not be empty";
                                            }
                                            else if(int.tryParse(value) == null){

                                              return "Age Should contains only numbers";
                                            }
                                            else {
                                              return null;
                                            }
                                          }
                                        },
                                          onSaved: (newValue) {
                                            inputs['age'] = int.parse(newValue!);
                                          },


                                      ),
                                    ),
                                  ),


                                SizedBox(
                                  width: 75,
                                  child: DropdownButtonFormField<String>(
                                    value: gender,
                                      onSaved: (newValue) {
                                        inputs['gender'] = newValue;
                                      },

                                      items: genders.map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    )).toList(),

                                    onChanged: (value) {
                                    setState(() {
                                    gender = value!;
                                    }
                                    );

                                    },

                                  ),
                                )
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  nameController.text = "";
                                  ageController.text = "";
                                  surnameController.text = "";

                                },
                                child: const Text('CANCEL'),
                              ),
                          isSaving ? const CircularProgressIndicator(): TextButton(
                            onPressed: ()   {
                              final formState  = _formKey.currentState;
                              if(formState == null) return;
                              if(formState.validate() == true){
                                formState.save();
                                _save();
                                nameController.text = "";
                                ageController.text = "";
                                surnameController.text = "";
                                Navigator.pop(context);
                                ref.refresh(teacherListProvider);

                              }
                            },
                            child: const Text('ADD'),
                          ),

                            ],
                          ),
                        ),
                      ],
                    )
                ),

              ] // Column Children,
            );
          },
        );
      },

      );

    }

  Future<void> _save()  async {
    bool finished = false;

    while(!finished){

    try{
      setState(() {
        isSaving = true;
      });
      await saver();
      finished = true;
      Fluttertoast.showToast(msg: "Saved successfully", backgroundColor: const Color.fromRGBO(66, 66, 66, 100), textColor: Colors.white);



    }catch(e){

      Fluttertoast.showToast(msg: "Something went wrong ${e.toString()}", backgroundColor: const Color.fromRGBO(66, 66, 66, 100), textColor: Colors.white);
    }
    finally{


      setState(() {
        isSaving = false;

      });
    }
    }

  }


  Future<void> saver() async {

    await ref.read(dataServiceProvider).addTeacher(Teacher.fromMap(inputs));
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

class TeacherRow extends ConsumerWidget {
   final Teacher teacher;


  const TeacherRow(this.teacher, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {


    return ListTile(
      leading: IntrinsicWidth(child: Center(child: Text(teacher.gender == "Kadın" ? "🙎🏻‍♀" : "🙎🏻‍♂"))),
      title: Text("${teacher.name} ${teacher.surname}",),


    );
  }
}