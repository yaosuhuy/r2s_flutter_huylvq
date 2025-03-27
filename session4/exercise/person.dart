import 'dart:io';

abstract class Person {
  String name;
  String gender;
  String phoneNumber;
  String email;

  Person(this.name, this.gender, this.phoneNumber, this.email);

  bool checkGender() {
    if (gender.toLowerCase() == "male" || gender.toLowerCase() == "female") {
      return true;
    } else {
      print("Invalid gender. Gender must be MALE or FEMALE!");
      return false;
    }
  }

  bool checkPhoneNumber() {
    if (RegExp(r'^09\d{8}$').hasMatch(phoneNumber)) {
      return true;
    } else {
      print(
        "Invalid phone number. Phone number must have 10 digits and start with 09.",
      );
      return false;
    }
  }

  bool checkEmail() {
    if (RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      return true;
    } else {
      print("Invalid email format. Please enter a valid email!");
      return false;
    }
  }

  void inputPerson() {
    print("Enter name: ");
    name = stdin.readLineSync()!;

    // do {
    //   print("Enter gender: ");
    //   gender = stdin.readLineSync()!;
    //   if (gender.toLowerCase() == "male" || gender.toLowerCase() == "female") {
    //     break;
    //   } else {
    //     print("Invalid gender. Gender must be MALE or FEMALE!");
    //   }
    // } while (true);
    do {
      print("Enter gender: ");
      gender = stdin.readLineSync()!;
      if (checkGender()) {
        break;
      }
    } while (true);

    do {
      print("Enter phone number: ");
      phoneNumber = stdin.readLineSync()!;
      if (checkPhoneNumber()) {
        break;
      }
    } while (true);

    do {
      print("Enter email: ");
      email = stdin.readLineSync()!;
      if (checkEmail()) {
        break;
      }
    } while (true);
  }

  void displayPerson() {
    print("Name: $name");
    print("Gender: $gender");
    print("Phone number: $phoneNumber");
    print("Email: $email");
  }
}
