import 'dart:io';
import 'dart:math';

double squareRootCalculate({required double number}) {
  return sqrt(number);
}

void main() {
  double number = 0;
  bool isValid = false;
  do {
    try {
    print("Enter a number: ");
    number = double.parse(stdin.readLineSync()!);
    if (number < 0) {
      throw Exception("Square root of negative number is not allowed");
    }
    isValid = true;
  } catch (e) {
    print(e);
  }
  } while (!isValid);
  print("Square root of $number is: ${squareRootCalculate(number: number)}");
}