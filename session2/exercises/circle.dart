import 'dart:io';

double circleArea({required int radius}) {
  return 3.14 * radius * radius;
}

double circlePerimeter({required int radius}) {
  return 2 * 3.14 * radius;
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
        print("Circle's area is: ${circleArea(radius: radius)}");
        break;
      case 2:
        print("Enter circle's radius: ");
        int radius = int.parse(stdin.readLineSync()!);
        print("Circle's perimeter is: ${circlePerimeter(radius: radius)}");
        break;
      case 3:
        return;
      default:
        print("Invalid choice");
    }
  } while (true);
}
