// main: entry point


import 'dart:io';

void main() {
  String name; // not null
  int age;
  
  print('Enter name: ');
  name = stdin.readLineSync()!;

  print('Enter age: ');
  age = int.parse(stdin.readLineSync()!); // convert string to int  

  print('Name: $name');
  print('Age: $age'); 
}