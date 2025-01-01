import 'dart:math' as math;

void main() {

//test
  // keywords
  // keywords
  // mohammad aqrbawi 
//sleeman mousa
  print('Anas');
  print('Anas');
  print('Anas Rasheed');
  print(258);
  print("anas rasheed");
  print("anas 22 dwawen + batata");
  print(125);
  print(-20); // int
  print(-20.25); // double
  print(true); // bool
  print(false); // bool
  print(125.1); // double
  print(1234567891234567891); // int
  print('-20'); // string
  // data type
  // Anas Rasheed         String   " " ' '
  // 125 -85  7           int
  // 125.77  -92.17       double
  // true false           bool
  // 19> digits num  BigInt
  // var
  // dynamic
  // Object

  print('10+20'); // 10+20
  print(10 + 20); // 30

  // variables

  // syntax

  // data type  name ;
  String myName; // null
  // data type name = value
  String yourName = 'Hamzeh';
  print(yourName); // Hamzeh
  yourName = 'Anas';
  print(yourName); // Anas

  int mark = 85;
  print(mark);
  mark = 95;
  print(mark);
  mark = 100;
  print(mark);
  print(mark - 20);

  // variable names convention
  // start with letter or _
  // Space not allowed
  // lower camel case   your name yourName   myName   ourMarksAndAverage
  // value meaning

  String x = "ZORX";
  String brand = 'ZORX';

  int studentAge = 30;

  int numberOfStudentEnrolledInAdvancedProgrammingCourse = 7; // 0
  int nnm = 7;

  // String

  String myFullName = "Anas Tala't Ibrahim Rasheed";
  print(myFullName);
  print("$myFullName This is my full name"); // concatenation
  print(myFullName); // =
  // myFullName = "Sami"; // reAssign new value
  // print(myFullName);
  myFullName = "$myFullName my name";
  print(myFullName);
  print("My full name is $myFullName"); // interpolation
  print("My full name is $myFullName");

  String student; // no value  null
  String student2 = ''; // value empty
  student = 'Haytham';
  print(student);
  print(student2);
  // int xx; // null
  // print(xx);
  print(myFullName);
  print(myFullName.isNotEmpty); // false
  print(myFullName.isEmpty); // false
  print(myFullName.length); // 35
  print(myFullName.contains('Anas')); //true
  print(myFullName.contains('rasheed')); //false case sensitive
  print(myFullName.contains('Rasheed')); //true case sensitive
  print(myFullName.contains("a't Ib")); //true case sensitive
  print(myFullName.contains("a't Ibrahim Ra")); //true case sensitive
  print(myFullName.contains("a't Ibrahim Rasheeed")); //false case sensitive
  print(myFullName.replaceAll('a', 'B'));
  print(myFullName);
  print(myFullName.replaceAll('a', "Anas"));
  print(myFullName.replaceFirst('a', "Anas"));
  print(myFullName.replaceRange(
      /*start index*/
      0,
      /*end index*/ 2, // not included
      "btata")); // index   0 base 1 base    34
  print(myFullName.replaceRange(30, 35, "Mohammad")); // 30-34
  // print(myFullName.replaceRange(30, 36, "Mohammad")); // 30-35 error
  print(myFullName.startsWith('Anas ')); // case sensitive true
  print(myFullName.startsWith('anas')); // case sensitive false
  print(myFullName.endsWith('Name')); // false
  print(myFullName.endsWith(' name')); // true
  print(myFullName.toLowerCase());
  print(myFullName.toUpperCase());
  print(myFullName.toLowerCase().startsWith('anas t')); // true
  print(myFullName.toUpperCase().contains('MY NAM')); // true
  print(" 3amo Sami ");
  print(" 3amo Sami ".trim()); // remove start and end spaces
  print(" 3amo Sami ".trimLeft()); // remove left space
  print(" 3amo Sami ".trimRight()); // remove right space
  print(myFullName);
  print(myFullName.indexOf('A')); // 0
  print(myFullName.indexOf('a')); // 2
  print(myFullName.lastIndexOf('a')); // 32
  print(myFullName.indexOf('as')); // 2
  print(myFullName.lastIndexOf('as')); // 21
  print(myFullName.lastIndexOf('Ana')); // 0
  print(myFullName.indexOf('Ana')); // 0
  print(myFullName.indexOf('Sami')); // -1 not found
  print(myFullName);
  print(myFullName[2]); // a
  print(myFullName[0]); // A
  print(myFullName[34]); // e
  // print(myFullName[90]); // error
  print(myFullName);
  print(myFullName.substring(5));
  print(myFullName.substring(12));
  print(myFullName.substring(19));
  // print(myFullName.substring(36));
  print(myFullName.substring(5, 10)); //  end index not included
  print(myFullName.substring(5, 15)); //  end index not included

  double average = 66;
  // int avg = 66;
  print(average);
  // print(avg);

  print(average.isNegative);
  average = -66;
  print(average.isNegative);
  average = average + 88;
  print(average);
  average = average + 1.85;
  print(average);
  print(average.round());
  average = 23.1;
  print(average.round());
  print(average.floor());
  average = 23.9999;
  print(average.floor());
  print(average.ceil());
  average = 23.01;
  print(average.ceil());

  // double -> String  toStringAsFixed
  // string  -> double double.parse()
  print((double.parse(average.toStringAsFixed(2)) + 25)
      .toStringAsFixed(4)); // casting

  int personMark = 1;

  personMark = personMark + 1;
  print(personMark); // 2
  // prefix// suffix postfix

  ++personMark; // personMark=personMark+1;
  print(personMark); // 3
  personMark++; // personMark=personMark+1;
  print(personMark); // 4
  personMark = personMark + 2;
  print(personMark); // 6
  personMark += 2; // personMark=personMark+2
  print(personMark); // 8
  personMark += 125;
  print(personMark); // 133
  --personMark; //  personMark = personMark - 1 ;
  print(personMark); // 132
  personMark -= 5; // personMark = personMark - 5;
  print(personMark); // 127

  personMark = personMark * 2;
  print(personMark); // 254

  personMark *= 2; // personMark = personMark * 2
  print(personMark); // 508

  // personMark=personMark/2; // syntax error

  print(personMark / 2);
  print(personMark ~/ 2);

  personMark = personMark ~/ 4;
  print(personMark);

  personMark = 20;
  print(++personMark + personMark++); // (21 + 21) 42   // 22
  print(personMark); // 22

  print(12 + 4 * 3 / 2 * 4 + 25); // 12 + 12 / 2 *4 + 25
  // 12 + 6 * 4 + 25
  // 12 + 24 + 25
  // 36 + 25 = 61.0
  personMark = 20;
  print(personMark++ * 2 / 8 + 4 * 22 + personMark--); // personMark  21  20
  // 40 / 8 + 4 * 22 + 21
  // 5 + 4 * 22 + 21
  // 5 + 88 + 21
  // 93 + 21 = 114.0
  print(personMark);

  print(22 * 4 + 14 - 8 * (22 - 10));
  //  22 * 4 + 14 - 8 * 12
  // 88 + 12 - 8 * 12
  // 88 + 12 - 96
  // 4

  print(25 > 28); // false
  print(25 >= 25); // true
  print(0 < 5); // true
  print(18 <= 25); // true
  print(5 == 5); // true
  print(8 == 4 * 2); // true

  print(4 * 2 + (22 - 8) * 4 >= 22 / 4 + (44 / 12) + 8); // true
  //  4 * 2 + 14 * 4 >= 22/4 + ( 44 / 12 ) + 8
  //  8 + 14 *4 >= 22/4 + ( 44 / 12 ) + 8
  // 8 + 56 >= 22/4 + ( 44 / 12 ) + 8
  // 64 >= 22/4 + 3.6 +8
  // 64 >= 5.5 + 3.6 +8
  // 64 >= 17.1

  print(math.pow(2, 3)); // 2 * 2 * 2     2^3
  print(math.pow(4, 3)); // 2 * 2 * 2     2^3

  print(math.max(25, 38));
  print(math.cos(160));
  print(math.sin(1));
  print(math.exp(49));
  print(math.sqrt(49));

  // truth table
  // OR
  // true || true = true
  // true || false = true
  // false || true = true
  // false || false = false

  // And
  // true && true = true
  // true && false = false
  // false && true = false
  // false && false = false
  print(4 * 2 + 55 - (11 - 5) >= 15 || 8 * 2 - 30 <= 60);
  // 4 * 2 + 55 - 6 >= 15 || 8 * 2 - 30 <= 60
  //  8 + 55 - 6 >= 15 || 8 * 2 - 30 <= 60
  // 57 >= 15 || 8 * 2 - 30 <= 60
  // true ||
  // true
  print(4 * 2 + 55 - (11 - 5) <= 15 && 8 * 2 - 30 <= 60);
  // false && 8 * 2 - 30 <= 60 false

  int? y; // null
  print((true || false) && false);
  print((false && true) || true);
  print(5 == 5 || y! == 2); // true ||
  // print(y! == 2 || 5 == 5); // error
  // print(5 == 5 && y! == 2); // error
  print(5 == 6 && y! == 2); // false ||

  // collections
  // list queue stack

  List list = [];
  print(list);
  list.add("anas");
  print(list);
  list.add(25);
  print(list);
  list.add(true);
  list.add(25 > 32 || 55 != 14);
  list.add(25 * 4);
  list.add(math.pow(2, 4));
  print(list);

  list.addAll([1, 'haytham', false]);
  print(list);
  print(list.isEmpty); // false
  print(list.isNotEmpty); // true
  print(list.last); // true
  print(list.first); // true
  print(list.contains('anas'));
  print(list.contains('Anas'));
  print(list.contains(12.5 * 4 / 2)); // 25.0
  print(list.indexOf(true)); // 2
  print(list.lastIndexOf(true)); // 3
  print(list[4]);
  print(list[4] + 25);
  print(list);
  print(list.reversed.toList());
  list.insert(2, 'Mohammad');
  print(list);
  list.insert(list.indexOf('haytham'), 'Qusay');
  print(list);
  // print(list[2] + 25); error
  // int x = 5 ;   x 1 value

  // var
  // dynamic

  var z = 15;
  print(z);
  z = 25;
  print(z);

  var zz = 'anas'; // zz String
  // zz=15; // error
  print(zz);

  dynamic d = 'anas';
  d = 15;
  d = true;
  print(d);

  print(d is bool);
  print(d is int);
  d = 15;
  print(d is int);

  // if condition     for loop      string (split)    list    oop

  average = 15;
  // print the average if the average is greater that 20 else print failed

  // syntax if condition
  // if (condition  (true)/false) {
  //
  // }

  if (average > 10) {
    print('success $average');
  }
  if (average > 20) {
    print('success22 $average');
  }

  // if (condition (false)) { // nested if
  //
  // } else {
  //
  // }

  if (average > 20) {
    print('success');
  } else {
    print('failed');
  }

  if (average > 50) {
    print('this student is perfect');
  } else {
    if (average > 40) {
      print('this student may success');
    } else {
      if (average > 30) {
        print('this student is about to fail');
      } else {
        print('this student is failed');
      }
    }
  }

  // else if
  if (average > 50) {
    print('this student is perfect');
  } else if (average > 40) {
    print('this student may success');
  } else if (average > 30) {
    print('this student is about to fail');
  } else {
    print('this student is failed');
  }

  if (average > 10) {
    print('10');
  }
  if (average > 12) {
    print('12');
  }

  // print(1-10)
  //
  print(1);
  print(2);
  print(3);
  print(4);
  print(5);
  print(6);
  print(7);
  print(8);
  print(9);
  print(10);
  // for loop
  // syntax for (/*start counter   optional*/; condition; /*increase/decrease counter optional*/){
  //
  //
  // }

  for (int counter = 1; counter <= 10; ++counter) {
    // counter 1 2 3 45 6789 10
    print(counter); // 1 2 3 4 5 6 7 8 9 10
  }
  for (int counter = 1; counter < 0; counter++) {
    print(counter); //
  }
  // for (int counter = 1; counter > 0; counter++) {
  //   print(counter); // 1 2 3 4 5 6 infinite loop  stackoverflow
  // }

  int myCounter = 1;
  for (; myCounter < 10; myCounter++) {
    print(myCounter); // 1 - 9
  }
  print(myCounter); // 10

  myCounter = 1;
  for (; myCounter > -20;) {
    print(myCounter); // 1 0 - -19 ...
    myCounter--;
  }

  //syntax while
  // while (condition){
  //
  // }
  // loop while

  myCounter = 1;
  while (myCounter > -10) {
    print("hello");
    myCounter--;
  }

  myCounter = 0;
  while (myCounter > 0) {
    print("Positive");
  }
  // do while   print nothing

  //syntax
  // do {
  // } while(condition)

  myCounter = 0;
  do {
    print("Positive"); // print positive one time
  } while (myCounter > 0);

  myCounter = 0;
  do {
    print("Positive");
    myCounter--; // print positive one time
  } while (myCounter > -10);
  // task

  for (int index = 0; index > -9; index -= 2) {
    print(index); // 0 -1 -2 ... -8
    index++;
  }

  for (int index = 0; index > -9; index -= 2) {
    print(index); // 0 -1 -3 -5 -7
    if (index.isEven) {
      index++;
    }
  }
  for (int index = 1; index <= 10; index += 2) {
    if (index % 3 == 0) {
      print("hello Rakan");
    } else if (index.isEven) {
      continue;
    } else {
      print(index); // 1 hello Rakan 5 7 hello Rakan
    }
  }

  for (int counter = 5; counter < 15; counter++) {
    if (counter % 7 == 0) {
      continue;
    }
    print(counter); // 5 6 8 9 10 11 12 13
  }
  for (int counter = 5; counter < 15; counter++) {
    if (counter % 7 == 0) {
      continue;
    }
    if (counter % 3 == 0) {
      break;
    }
    print(counter); // 5
  }
  print('*************');
  for (int counter = 1; counter < 5; counter++) {
    // 1 2 3 4
    // nested loop
    for (int counter2 = 3; counter2 < 7; counter2++) {
      if (counter2 == 6) break;
      print(counter2); // 3 4 5 3 4 5 3 4 5 3 4 5
    }
    if (counter == 3) break;
  }

  List<int> marks = [
    70, // index
    75,
    25,
    95,
    88,
    17,
    67,
    72,
    28,
    33,
    79
  ]; // alt + ctrl + l reformat code

  // find the max value in the list

  for (int index = 0; index < marks.length; index++) {
    print(marks[index]); // 70 75 25 95 .... 79
  }

  int max = marks.first; //0
  for (int index = 0; index < marks.length; index++) {
    if (marks[index] > max) {
      max = marks[index]; // 75  95
    }
  }
  print('the max mark is $max');

  // min

  int min = marks.first; // 0
  for (int index = 1; index < marks.length; index++) {
    if (marks[index] < min) {
      min = marks[index];
    }
  }
  print("the min is $min");

  //
  List<int> temps = [-10, -20, -15];
  max = temps.first;
  for (int index = 0; index < temps.length; index++) {
    if (temps[index] > max) {
      max = temps[index]; // 75  95
    }
  }
  print(max); // 0

  print(marks.any((element) => element > 90));
  print(marks.any((element) => element < 10));
  print(marks.any((element) => element.isOdd));
  print(marks.any((element) => element + 10 > 100));
  print(marks.any((element) => element == 50)); // true

  print(marks.every((element) => element > 0));
  print(marks.every((element) => element > 20));
  print(marks.every((element) => element % 7 == 1));
  print(marks
      .every((element) => element.isOdd)); // all items accept the condition

  //
  List<int> marksLessThan50 = [];
  for (int index = 0; index < marks.length; index++) {
    if (marks[index] < 50) marksLessThan50.add(marks[index]);
  }
  print(marksLessThan50);
  print(marks.where((element) => element < 50).toList());
  marksLessThan50.clear();
  print(marksLessThan50);
  marksLessThan50 = marks.where((element) => element < 50).toList();
  print(marksLessThan50);

  //
  print(marks.firstWhere((element) => element < 50)); //
  if (marks.any((element) => element < 10)) {
    print(marks.firstWhere((element) => element < 10)); //
  }

  List<String> marksWithNames = marks.map((e) => "$e anas").toList();
  print(marksWithNames);

  List<double> doubleMarks = marks.map((e) => e + 1.5).toList();
  print(doubleMarks);
  doubleMarks = [];
  doubleMarks = marks
      .where((element) => element < 50)
      .toList()
      .map((e) => e + (50.1 - e)) // 27 + (50.1 - 27) = 50.1
      .toList();
  print(doubleMarks);

  // task
  // write a simple code that find the sum and the avg for the marks (double)  [10]
  // find the max and the min
  // find the second max and the second min
  // List<String> names  omar ahmad
  // print all the names that have length more than 4
  // print all the names that ends with letter r or R
  // print all the names that start with ah or AH or mo or MO
  // make another list and insert all the names that have even length inside it and print it

  List<double> stepByStepMarks = [
    27,
    72,
    91.2,
    48,
    86,
    74,
    50.3,
    10,
    34,
    76,
    81.5,
    64,
    57
  ];
  double sum = 0;
  for (int index = 0; index < stepByStepMarks.length; index++) {
    sum = sum + stepByStepMarks[index];
  }
  print('sum is $sum');
  print("avg is ${sum / stepByStepMarks.length}");

  sum = 0;
  // foreach
  for (double item in stepByStepMarks) {
    // foreach
    sum = sum + item;
  }
  print('sum is $sum');
  print("avg is ${sum / stepByStepMarks.length}");
  sum = 0;
  for (var item in stepByStepMarks) {
    sum = sum + item;
  }
  print('sum is $sum');
  print("avg is ${sum / stepByStepMarks.length}");

  // null safety

  String? v; // null  it can be null nullable variable
  print(v); // syntax

//  print(v!
  //    .length); // string 0  // >0   null.length XXX   null  symantc error logical error

  late String? vv;
  vv = '';
  print(vv); // null

  // try catch handling exceptions
  myName = "Anas";
  print(myName[0]); // A

  try {
    print(myName[4]); // error
  } catch (error) {
    print(error);
    print('please call support 0789465465');
  }
  print("sami");

  // oop

  // functions

  stepByStepMarks = [10, 20, 30, 40, 50, 60, 70, 80, 90];
  // find max

  double doubleMax = stepByStepMarks.first;
  for (var item in stepByStepMarks) {
    if (item > doubleMax) doubleMax = item;
  }
  print('max is $doubleMax');

  List<double> stepMarks = [
    10,
    60,
    80,
    95,
    17,
    489,
    65,
    57,
    17,
    2,
    17,
    54,
    654,
    4,
    865
  ];
  //
  // doubleMax = stepMarks.first;
  // for (var item in stepMarks) {
  //   if (item > doubleMax) {
  //     doubleMax = item;
  //   }
  // }
  print('max is ${findMaxFromList(stepMarks)}');
  print('max is ${findMaxFromList(stepByStepMarks)}');
  print('min is ${findMinFromList(stepByStepMarks)}');
  print('max is ${findMaxFromList2(
    list: stepByStepMarks,
  )}');
  // print('max is ${findMaxFromList3()}');
  // functions remove duplicate

  print(pi() + 1.5);
  print(myNameFun("Anas"));
  print(myFullNameFun("Anas", "Rasheed"));
  printData("Laptop,Computer,TV");
  printData("PS4,Computer,TV");

  // types of arguments parameters

  // dart
}

// box   input unlimited     one output
// out of the main

// syntax

//data type  function name (// parameters   arguments , variables) {
//
//
// }

double pi() {
  return 3.14;
  // dead code
  print('batata');
}

String myNameFun(String name) {
  // one argument one parameter
  return "my name is $name";
}

// variable  lower camel case
String myFullNameFun(String name, String familyName) {
  // 2 parameters
  return "my name is $name $familyName";
}

void printData(String data) {
  // void
  print("my data collection is $data");
  if (data.toLowerCase().contains('laptop')) {
    return;
  }
  print("no laptop from the collection");
  // print("batata");
  // no need for return
}

double findMaxFromList(List<double> list) {
  double max = list.first;
  for (var item in list) {
    if (item > max) {
      max = item;
    }
  }
  return max;
}
// two types  optional parameters   named parameters

double findMaxFromList2({required List<double> list, int? vv, String c = ''}) {
  // default value
  print(c);
  // named optional parameter
  double max = list.first;
  for (var item in list) {
    if (item > max) {
      max = item;
    }
  }
  return max;
}

// classes
// find min from list

double findMinFromList(List<double> list) {
  double min = list.first;
  for (var item in list) {
    if (item < min) min = item;
  }
  return min;
}
