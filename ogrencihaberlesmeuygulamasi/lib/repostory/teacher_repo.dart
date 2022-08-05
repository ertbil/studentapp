import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TeacherRepo extends ChangeNotifier{
  List teacher = [
    Teacher("Can","Yılmaz",42,"Erkek"),
    Teacher("Mehmet", "Çelik", 48, "Erkek"),

  ];



}

final teacherProvider = ChangeNotifierProvider((ref) {
  return TeacherRepo();
},);

class Teacher{
  String name;
  String surname;
  int age;
  String gender;

  Teacher(this.name, this.surname, this.age, this.gender);


}