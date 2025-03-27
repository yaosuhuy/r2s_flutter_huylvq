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

  bool isStudentIDValidated() {
    if (existingStudentIDs.contains(studentID)) {
      print("Student ID is already taken, please enter another ID");
      return false;
    } else {
      existingStudentIDs.add(studentID);
      return true;
    }
  }

  bool isCheckMarkValidated(double value){
    if (value < 0 || value > 10) {
      print("Invalid input: Mark must be between 0 and 10");
      return false;
    } else {
      return true;
    }
  }

  double inputMark(String prompt) {
    double value;
    do {
      try {
        print(prompt);
        value = double.parse(stdin.readLineSync()!);
        if (isCheckMarkValidated(value)) {
          break;
        }
      } catch (e) {
        print("Invalid input: Theory mark must be a number");
      }
    } while (true);
    return value;
  }

  @override
  void inputPerson() {
    do {
      print("Enter student ID: ");
      studentID = stdin.readLineSync()!;
      if (isStudentIDValidated()) {
        break;
      }
    } while (true);
    inputPersonDetails();
  }

  void inputPersonDetails() {
    super.inputPerson();
    theory = inputMark("Enter theory mark: ");
    practice = inputMark("Enter practice mark: ");
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