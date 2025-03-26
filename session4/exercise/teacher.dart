import 'dart:io';

import 'person.dart';

class Teacher extends Person {
  double basicSalary;
  double subsidy;

  Teacher(
    String name,
    String phoneNumber,
    String gender,
    String email,
    this.basicSalary,
    this.subsidy,
  ) : super(name, phoneNumber, gender, email);

  double calculateSalary() {
    return basicSalary + subsidy;
  }

  @override
  void inputPerson(){
    super.inputPerson();

    do {
      try {
        print("Enter basic salary: ");
        basicSalary = double.parse(stdin.readLineSync()!);
        break;
      } catch (e) {
        print("Invalid input: Basic salary must be a number");
      }
    } while (true);

    do {
      try {
        print("Enter subsidy: ");
        subsidy = double.parse(stdin.readLineSync()!);
        break;
      } catch (e) {
        print("Invalid input: Subsidy must be a number");
      }
    } while (true);
  }

  @override
  void displayPerson() {
    super.displayPerson();
    print("Basic salary: $basicSalary"+r"$");
    print("Subsidy: $subsidy"+r"$");
    print("Total salary: ${calculateSalary()}"+r"$");
  }
}
