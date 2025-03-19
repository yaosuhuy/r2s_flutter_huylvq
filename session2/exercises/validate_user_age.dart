import 'dart:io';

String validateAge(int age) {
  return "Access Granted";
}

void main() {
  int age = 0;
  bool isValid = false;
  do {
    try {
      print("Enter age: ");
      String? input = stdin.readLineSync();
      if (input == null || int.tryParse(input) == null) {
        throw Exception("Invalid input: Age must be an integer");
      }
      age = int.parse(input);
      if (age < 0) {
        throw Exception("Age cannot be negative");
      }
      if (age < 18) {
        throw Exception("User is underage");
      }
      isValid = true;
    } catch (e) {
      print("Error: " + e.toString());
    }
  } while (!isValid);
  print(validateAge(age));
}
