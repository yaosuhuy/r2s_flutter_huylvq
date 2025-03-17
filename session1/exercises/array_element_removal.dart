import 'dart:io';
import 'dart:math';

void main() {
  var random = Random();
  int numberOfElements, targetNumber;
  do {
    print("Enter number of elements (1-100): ");
    numberOfElements = int.parse(stdin.readLineSync()!);
  } while (numberOfElements <= 1 || numberOfElements >= 100);
  print("Enter target number (1-100): ");
  targetNumber = int.parse(stdin.readLineSync()!);
  List<int> list = List.generate(
    numberOfElements,
    (_) => random.nextInt(100) + 1,
  );
  print("Array before removal");
  for (int element in list) {
    print("Element is: $element");
  }
  if (!list.contains(targetNumber)) {
    print("Target number not found");
    return;
  } else {
    print("Array after removal");
    do {
      list.remove(targetNumber);
    } while (list.contains(targetNumber));
    for (int element in list) {
      print("Element is: $element");
    }
  }
}
