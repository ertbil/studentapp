import 'dart:convert';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studentapp/models/teacher.dart';
import 'package:http/http.dart' as http;

class DataService {
  final String baseUrl = 'https://62f10793e2bca93cd242a81f.mockapi.io/teacher';
  Random random = Random();

  

  Future<Teacher> downloadTeacher() async {
    http.Response response = await http.get(Uri.parse('$baseUrl/${random.nextInt(13)}'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Teacher.fromMap(jsonDecode(response.body));
    } else {

      throw Exception('Teacher download ended with failure ${response.statusCode}');
    }

  }

  Future<void> addTeacher(Teacher teacher) async {

    final  response = await http.post(
        Uri.parse(baseUrl),
        headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(teacher.toMap()),

    );
    if (response.statusCode == 201) {

      return;
    } else {

      throw Exception('Teacher creation ended with failure ${response.statusCode}');
    }
  }

  Future<List<Teacher>> getTeachers() async {
    http.Response response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {

      final l = jsonDecode(response.body);
      return l.map<Teacher>((e)=> Teacher.fromMap(e)).toList();


    } else {

      throw Exception('Teachers download ended with failure ${response.statusCode}');
    }
  }


}

final dataServiceProvider = Provider((ref) => DataService());