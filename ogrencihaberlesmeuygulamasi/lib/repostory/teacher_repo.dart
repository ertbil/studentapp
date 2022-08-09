import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studentapp/models/teacher.dart';
import 'package:studentapp/services/data_service.dart';

class TeacherRepo extends ChangeNotifier{
  List teachers = [
    Teacher("Can","Yılmaz",42,"Erkek"),
    Teacher("Mehmet", "Çelik", 48, "Erkek"),

  ];
  final DataService dataService;

  TeacherRepo(this.dataService);
  Future<void> download() async {
   Teacher teacher = await dataService.downloadTeacher();

    teachers.add(teacher);
    notifyListeners();
  }

}

final teacherProvider = ChangeNotifierProvider((ref) {

  return TeacherRepo(ref.watch(dataServiceProvider));
},);

