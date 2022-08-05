import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StudentRepo extends ChangeNotifier{
  final student = [
    Student("Ali","Yılmaz",18,"Erkek"),
    Student("Veli", "Çelik", 18, "Erkek"),
    Student("Ayşe", "Doğan", 20, "Kadın")
  ];
  final Set<Student> liked = {};

  void like(Student student, bool liked) {
    if(liked){
    this.liked.add(student);

    }else{
      this.liked.remove(student);
    }
    notifyListeners();
  }

  isLiked(Student student) {
    return liked.contains(student);
  }

}
final studentProvider = ChangeNotifierProvider((ref) {
      return StudentRepo();

});


class Student{
  String name;
  String surname;
  int age;
  String gender;

  Student(this.name, this.surname, this.age, this.gender);


}