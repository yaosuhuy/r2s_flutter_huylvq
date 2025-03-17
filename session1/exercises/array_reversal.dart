import 'dart:io';
import 'dart:math';

void main(){
  var random = Random();
  int numberOfElements;
  do {
    print("Enter number of elements (1-100): ");
    numberOfElements = int.parse(stdin.readLineSync()!);
  } while (numberOfElements <= 1 || numberOfElements >= 100);
  List<int> list = List.generate(numberOfElements, (_) => random.nextInt(100) + 1);
  print("Elements before reversal");
  for (int element in list){
    print("Element: $element");
  }
  List<int> reversedList = List.from(list.reversed);
  print("Elements after reversal");
  for (int element in reversedList){
    print("Element: $element");
  }
}