import 'dart:io';

import 'person.dart';

class Student extends Person {
  String studentID;
  double theory;
  double practice;

  // static variable is shared among all instances of the class
  static List<String> existingStudentIDs = [];

  Student(
    String name,
    String phoneNumber,
    String gender,
    String email,
    this.studentID,
    this.theory,
    this.practice,
  ) : super(name, phoneNumber, gender, email);

  double calculateFinalMark() {
    return (theory + practice) / 2;
  }

  @override
  void inputPerson() {
    super.inputPerson();

    do {
      print("Enter student ID: ");
      studentID = stdin.readLineSync()!;
      if (existingStudentIDs.contains(studentID)) {
        print("Student ID is already taken, please enter another ID");
      } else {
        existingStudentIDs.add(studentID);
        break;
      }
    } while (true);

    do {
      try {
        print("Enter theory mark: ");
        theory = double.parse(stdin.readLineSync()!);
        break;
      } catch (e) {
        print("Invalid input: Theory mark must be a number");
      }
    } while (true);

    do {
      try {
        print("Enter practice mark: ");
        practice = double.parse(stdin.readLineSync()!);
        break;
      } catch (e) {
        print("Invalid input: Practice mark must be a number");
      }
    } while (true);
  }

  @override
  void displayPerson() {
    super.displayPerson();
    print("Student ID: $studentID");
    print("Theory mark: $theory");
    print("Practice mark: $practice");
    print("Final mark: ${calculateFinalMark()}");
  }
}
