import 'package:fip8/oop/oop_example.dart';

void main() {
  Person person = Person(
      name: "Wessam",
      age: 45,
      height: 170,
      weight: 54,
      ssn: 'sdsd',
      gender: 'Female',
      salary: 150);
  print(person.getGender());
  person.setGender('male');
  print(person.getGender());
  print(person.gender);
  person.gender = 'male';
  person.gender = 'female';

  //
}
