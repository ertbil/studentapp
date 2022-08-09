class Teacher{
  String name;
  String surname;
  int age;
  String gender;

  Teacher(this.name, this.surname, this.age, this.gender);
  Teacher.fromMap(Map<String, dynamic> m) : this(
    m['name'], m['surname'], m['age'], m['gender']
  );


}