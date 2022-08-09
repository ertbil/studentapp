import 'dart:convert';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studentapp/models/teacher.dart';
import 'package:http/http.dart' as http;

class DataService {
  final String baseUrl = 'https://62f10793e2bca93cd242a81f.mockapi.io/teacher';
  Random random = Random();

  

  Future<Teacher> downloadTeacher() async {
    http.Response response = await http.get(Uri.parse('$baseUrl/${random.nextInt(10)}'));
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Teacher.fromMap(jsonDecode(response.body));
    } else {

      throw Exception('Teacher download ended with failure ${response.statusCode}');
    }

  }


}

final dataServiceProvider = Provider((ref) => DataService());