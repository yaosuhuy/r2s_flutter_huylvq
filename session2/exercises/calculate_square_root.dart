import 'dart:io';
import 'dart:math';

double calculateSqaureRoot({required double number}) {
  return sqrt(number);
}

void main() {
  double number = 0;
  bool isValid = false;
  do {
    try {
      print("Enter a number: ");
      String? input = stdin.readLineSync();
      if (input == null || double.tryParse(input) == null) {
        throw Exception("Invalid input: Not a number");
      }
      number = double.parse(input);
      if (number < 0) {
        throw Exception("Square root of negative number is not allowed");
      }
      isValid = true;
    } catch (e) {
      print("Error: " + e.toString());
    }
  } while (!isValid);
  print("Square root of $number is: ${calculateSqaureRoot(number: number)}");
}
