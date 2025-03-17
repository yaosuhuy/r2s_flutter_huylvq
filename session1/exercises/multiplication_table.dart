import 'dart:io';

void main() {
  int number;

  do {
    print('Enter a number: ');
    number = int.parse(stdin.readLineSync()!);
  } while (number < 2 || number > 9);

  for (int i = 1; i <= 9; i++) {
    print('$number x $i = ${number * i}');
  }
}
