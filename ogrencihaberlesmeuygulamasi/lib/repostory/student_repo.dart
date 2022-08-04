class StudentRepo{
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


  }

  isLiked(Student student) {
    return liked.contains(student);

  }


}

class Student{
  String name;
  String surname;
  int age;
  String gender;

  Student(this.name, this.surname, this.age, this.gender);


}