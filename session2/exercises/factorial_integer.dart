import 'dart:io';

void factorialCaculator({required int number}) {
  int factorial = 1;
  for (int i = 1; i <= number; i++) {
    factorial *= i;
  }
  print("Factorial of $number is: $factorial");
}

void main(){
  print("Enter a number: ");
  int number = int.parse(stdin.readLineSync()!);
  factorialCaculator(number: number);
}