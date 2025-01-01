// Class   object
class Person {
  //
  // new data type string int double bool var dynamic
  // model bean
  //
  String name = '';
  double age = 0;
  double height = 0;
  double weight = 0;
  String ssn = '';
  double salary = 0;
  String _gender =
      ''; // private public   access modifiers    private outside the file
  static String country = 'Jordan';

// constructor   3 types
// function method default values

  // Person(
  //     {required String myName,
  //     required double myAge,
  //     required double myHeight,
  //     required double myWeight,
  //     required String mySsn,
  //     double mySalary = 0}) {
  //   name = myName;
  //   age = myAge;
  //   height = myHeight;
  //   weight = myWeight;
  //   ssn = mySsn;
  //   salary = mySalary;
  // } // con
  // Person(
  //     {required String name,
  //     required double age,
  //     required double height,
  //     required double weight,
  //     required String ssn,
  //     double salary = 0}) {
  //   this.name = name;
  //   this.age = age;
  //   this.height = height;
  //   this.weight = weight;
  //   this.ssn = ssn;
  //   this.salary = salary;
  // } // constructor
  Person(
      {required this.name,
      required this.age,
      required this.height,
      required this.weight,
      required this.ssn,
      this.salary = 0,
      String gender = 'Male'}) {
    // validation
    if (gender.toLowerCase() != 'male' && gender.toLowerCase() != 'female') {
      throw Exception(
          "the gender $gender is not correct please enter correct value");
    }
    _gender = gender;
  }

  void setGender(String newGender) {
    // setter
    if (newGender.toLowerCase() != 'male' &&
        newGender.toLowerCase() != 'female') {
      throw Exception(
          "the gender $newGender is not correct please enter correct value");
    }
    _gender = newGender;
  }

  // getter

  String getGender() {
    return _gender;
  }

  String get gender {
    return _gender;
  }

  set gender(String newGender) {
    if (newGender.toLowerCase() != 'male' &&
        newGender.toLowerCase() != 'female') {
      throw Exception(
          "the gender $newGender is not correct please enter correct value");
    } //setter method
    _gender = newGender;
  } // constructor

  Person.employee(
      // named constructor
      {required this.name,
      required this.age,
      required this.height,
      required this.weight,
      required this.ssn,
      required this.salary,
      String gender = 'Male'}) {
    if (gender.toLowerCase() != 'male' && gender.toLowerCase() != 'female') {
      throw Exception(
          "the gender $gender is not correct please enter correct value");
    }
    _gender = gender;
  }

  // factory singelton design pattern  arabic english
  String getPersonInfo() {
    //  method
    return "Person name is $name , Person age is $age , Person height is $height , Person weight is $weight , Person SSN is $ssn";
  }

  String getEmployeePersonInfo() {
    if (salary == 0) {
      throw Exception("This user has no salary");
    }
    return '${getPersonInfo()} , Person salary is $salary';
  }
}

// encapsulation
void main() {
  String anas = 'anas';

  Person sami = Person(
      name: "Sami",
      age: 20,
      height: 180,
      weight: 75,
      ssn: "9898987897",
      salary: 580,
      gender:
          "male"); // new instance new object // className   variableName = className();

  print(sami.name);
  print(sami.age); // 20
  print(sami.height);
  print(sami.weight);
  print(sami.ssn);
  sami.age = ++sami.age;
  print(sami.age); // 21
  sami.salary = 500;
  print(sami.salary);

  //

  Person mohammad = Person(
      name: "Mohammad sa3ed",
      age: 70,
      height: 160,
      weight: 55,
      ssn: "8884654654"); //
  print("mohammad name is ${mohammad.name}");
  print("mohammad age is ${mohammad.age}");
  print(mohammad.salary);

  Person rahaf = Person.employee(
      name: "Rahaf",
      age: 22,
      height: 160,
      weight: 50,
      ssn: '2015616546',
      salary: 700,
      gender: 'Female');

  print(sami.getPersonInfo());
  print(mohammad.getPersonInfo());
  print(rahaf.getPersonInfo());
  print(rahaf.getEmployeePersonInfo());
  try {
    print(mohammad.getEmployeePersonInfo());
  } catch (e) {
    print(e.toString());
    print('iNSUFFCINT FUND');
  }

  rahaf.ssn = '1';
  rahaf.weight = -50; // without validation
  rahaf._gender = 'BATATA';
  final String soso = 'soso';
  // soso='anas';
  // sami='batata';
  print(soso);
  const String haitham = 'Haitham';
  // haitham='aasdfg';
  print(haitham);

  final ss;

  ss = 'ss';

  const String aa = 'aa';
  print(aa);
  print(ss);

  Person rakan = Person(
      name: "Rakan", age: 25, height: 175, weight: 80, ssn: "999458748994");
  Person aseel = Person(
      name: "Aseel", age: 22, height: 160, weight: 48, ssn: "206498465465");

  print(aseel.name);
  print(rakan.name);
  print(Person.country);
  Person.country = "Palestine";
  print(Person.country);
  // rahaf.gender = "BATATA";
  // print(rahaf.gender);
}
// task class Employee   Name  numberOfExperience   PositionName  Salary  CompanyName
// create 3 employees
// make a two Constructor
//  make all the fields private
// make validation on all fields
// change all the values using setter
// make a method called printEmployeeData to print all details

// final static const  inheritance composition  ploymorphism  dependency injection
