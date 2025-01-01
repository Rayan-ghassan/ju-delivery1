class Person {
  // parent super
  String name;
  double age;
  double height;
  double weight;

  Person(
      {required this.name,
      required this.age,
      required this.height,
      required this.weight});

  Person.cc(
      {required this.name,
      required this.age,
      required this.height,
      required this.weight});

  String getData() {
    return "name $name Age $age  height $height weight $weight";
  }

  @override
  bool operator ==(Object other) {
    if (other is Person) {
      return name == other.name &&
          age == other.age &&
          height == other.height &&
          weight == other.weight;
    }
    return false;
  }

  @override
  int get hashCode => super.hashCode;
}

// child
class Employee extends Person {
  double salary;
  String positionName;

  Employee(
      {required this.salary,
      required this.positionName,
      required String name,
      required double age,
      required double height,
      required double weight})
      : super(name: name, age: age, height: height, weight: weight);

  @override
  String getData() {
    return "${super.getData()} Salary $salary Position name $positionName";
  }

  @override
  bool operator ==(Object other) {
    if (other is Employee) {
      return super == other &&
          salary == other.salary &&
          positionName == other.positionName;
    }
    return false;
  }

  @override
  int get hashCode => super.hashCode ^ salary.hashCode ^ positionName.hashCode;
}

// class PartTimeEmployee extends Employee{
//
//
// }
// inheritance
void main() {
  Employee employee = Employee(
      salary: 100,
      positionName: "developer",
      name: "Sleeman",
      height: 180,
      weight: 80,
      age: 25);

  Employee employee2 = Employee(
      salary: 150,
      positionName: "marketing",
      name: "Sleeman",
      height: 180,
      weight: 80,
      age: 25);

  Person anas = Person(name: "Anas", age: 33, height: 185, weight: 698);
  Person anas2 = Person(name: "Anas", age: 33, height: 185, weight: 698);
  print(anas == 5);
  print(anas == anas2); // false
  // print(employee.getData());
  print(employee == employee2); // false true false false  check address

  // String a = 'a';
  // String b = 'a';
  // print(a == b); // true
}
