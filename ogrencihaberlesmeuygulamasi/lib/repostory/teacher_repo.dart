class TeacherRepo{
  List teacher = [
    Teacher("Can","Yılmaz",42,"Erkek"),
    Teacher("Mehmet", "Çelik", 48, "Erkek"),

  ];



}

class Teacher{
  String name;
  String surname;
  int age;
  String gender;

  Teacher(this.name, this.surname, this.age, this.gender);


}