import 'dart:io';

void main() {
  String grade;
  num salary, allowance, totalSalary;

  print('Enter grade: ');
  grade = stdin.readLineSync()!;

  switch (grade) {
    case 'A':
      salary = 50000;
      allowance = 300;
      break;
    case 'B':
      salary = 40000;
      allowance = 250;
      break;

    default:
      salary = 20000;
      allowance = 100;
  }
  totalSalary = salary + allowance;
  print('Total salary: $totalSalary');
}
