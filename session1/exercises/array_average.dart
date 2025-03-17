import 'dart:io';
import 'dart:math';

void main(){
  var random = Random();
  int numberOfElements, sum = 0;
  do {
    print("Enter number of elements (1-100): ");
    numberOfElements = int.parse(stdin.readLineSync()!);
  } while (numberOfElements <= 1 || numberOfElements >= 100);
  List<int> list = List.generate(numberOfElements, (_) => random.nextInt(100) + 1);
  for (int element in list){
    print("Element is: $element");
    sum+=element;
  }
  print("Average is: ${sum/numberOfElements}");
}