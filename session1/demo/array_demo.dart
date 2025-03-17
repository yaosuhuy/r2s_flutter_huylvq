import 'dart:math';

void main(){
  var random = Random();
  // 10 means 10 elements
  // random.nextInt(100) + 1 means 1 to 100
  // if not + 1 means 0 to 99
  // _ is a throwaway variable
  List<int> list = List.generate(10, (_) => random.nextInt(100) + 1);

  print("Using for-in loop");
  for (int element in list){
    print("Element is: $element");
  }
}