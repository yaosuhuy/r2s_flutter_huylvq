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

  double inputMoney(String prompt) {
    double value;
    do {
      try {
        print(prompt);
        value = double.parse(stdin.readLineSync()!);
        break;
      } catch (e) {
        print("Invalid input: Salary/Subsidy must be a number");
      }
    } while (true);
    return value;
  }

  @override
  void inputPerson(){
    super.inputPerson();
    inputMoney("Enter basic salary: ");
    inputMoney("Enter subsidy: ");
  }

  @override
  void displayPerson() {
    super.displayPerson();
    print("Basic salary: $basicSalary"+r"$");
    print("Subsidy: $subsidy"+r"$");
    print("Total salary: ${calculateSalary()}"+r"$");
  }
}
