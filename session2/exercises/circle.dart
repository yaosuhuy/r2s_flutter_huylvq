import 'dart:io';
import 'dart:math';

double circleAreaCalculator({required int radius}) {
  return pi * radius * radius;
}

double circlePerimeterCalculator({required int radius}) {
  return pi * radius;
}

void main() {
  do {
    print("1. Calculate circle's area");
    print("2. Calculate circle's perimeter");
    print("3. Exit");
    print("Enter your choice: ");
    int choice = int.parse(stdin.readLineSync()!);
    switch (choice) {
      case 1:
        print("Enter circle's radius: ");
        int radius = int.parse(stdin.readLineSync()!);
        print("Circle's area is: ${circleAreaCalculator(radius: radius)}");
        break;
      case 2:
        print("Enter circle's radius: ");
        int radius = int.parse(stdin.readLineSync()!);
        print("Circle's perimeter is: ${circlePerimeterCalculator(radius: radius)}");
        break;
      case 3:
        break;
      default:
        print("Invalid choice");
    }
  } while (true);
}
