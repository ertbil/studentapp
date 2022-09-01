import 'package:flutter_test/flutter_test.dart';
import 'package:studentapp/models/student.dart';
import 'package:studentapp/repostory/student_repo.dart';

void main() {
  test('Öğrenci beğnilmiş olarak gözüküyor', () {
    final StudentRepo studentRepo = StudentRepo();
    final Student student = Student("john","doe",15,"Erkek");

    group("default false mu", () {
      studentRepo.student.add(student);
      expect(studentRepo.isLiked(student), false); })
    ;


    group("Sevme fonksiyonu çalışıyor mu?", () { studentRepo.like(student, true);
    expect(studentRepo.isLiked(student), true);
    studentRepo.like(student, false);
    expect(studentRepo.isLiked(student), false);
    });





  });
}