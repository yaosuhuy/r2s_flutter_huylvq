import 'dart:io';

import 'student.dart';

void printStudentDetails({required Student student}) {
  print("Student's ID: ${student.id}");

  print("Student's name: ${student.name}");

  print("Student's mark 1: ${student.mark1}");

  print("Student's mark 2: ${student.mark2}");

  print("Student's mark 3: ${student.mark3}");

  print("Total score: ${student.total()}");

  print("Average score: ${student.average()}");

  print("-------------------------------");
}

void inputStudentDetails({required Student student, required List<Student> students}) {
  bool isUniqueId = false;

  do {
    print("Enter student's id: ");

    int id = int.parse(stdin.readLineSync()!);

    isUniqueId = students.every((s) => s.id != id);

    if (isUniqueId) {
      student.id = id;
    } else {
      print("ID already exists. Please enter a unique ID.");
    }
    
  } while (!isUniqueId);

  print("Enter student's name: ");
  student.name = stdin.readLineSync();

  print("Enter student's mark 1: ");
  student.mark1 = double.parse(stdin.readLineSync()!);

  print("Enter student's mark 2: ");
  student.mark2 = double.parse(stdin.readLineSync()!);

  print("Enter student's mark 3: ");
  student.mark3 = double.parse(stdin.readLineSync()!);
}

void main() {
  // var student1 =  Student();
  // var student2 =  Student();
  // var student3 =  Student();

  // student1.name = 'John';
  // student1.mark1 = 80;
  // student1.mark2 = 60;
  // student1.mark3 = 70;

  // student2.name = 'Jane';
  // student2.mark1 = 90;
  // student2.mark2 = 60;
  // student2.mark3 = 80;

  // student3.name = 'Smith';
  // student3.mark1 = 70;
  // student3.mark2 = 60;
  // student3.mark3 = 90;

  // improve 1st time
  // inputStudentDetails(student: student1);
  // inputStudentDetails(student: student2);
  // inputStudentDetails(student: student3);

  // printStudentDetails(student: student1);
  // printStudentDetails(student: student2);
  // printStudentDetails(student: student3);

  // improve 2nd time
  List<Student> students = [];
  int choice;
  do {
    print('1. Add student');
    print('2. Print student details');
    print('3. Find student by ID');
    print('4. Find student by name');
    print('0. Exit');

    print('Enter your choice: ');
    choice = int.parse(stdin.readLineSync()!);

    switch (choice) {
      // case 1
      case 1:
        var student = Student();

        inputStudentDetails(student: student, students: students);

        students.add(student);
        break;
      // case 2
      case 2:
        for (Student student in students) {
          printStudentDetails(student: student);
        }
        break;
      // case 3
      case 3:
        print('Enter student ID you want to find: ');
        int findId = int.parse(stdin.readLineSync()!);

        Student? foundStudent;

        for (Student student in students) {
          if (student.id == findId) {
            foundStudent = student;
            break;
          }
        }

        if (foundStudent != null) {
          printStudentDetails(student: foundStudent);
        } else {
          print('Student not found');
        }
        break;
      // case 4
      case 4:
        print('Enter student name you want to find: ');
        String findName = stdin.readLineSync()!;

        List<Student> foundStudents = [];

        for (Student student in students) {
          if (student.name!.toLowerCase().contains(findName.toLowerCase())) {
            foundStudents.add(student);
          }
        }
      
        if (foundStudents.isNotEmpty) {
          for (Student student in foundStudents) {
            printStudentDetails(student: student);
          }
        } else {
          print('Student not found');
        }
        break;
      default:
        print('Invalid choice');
    }
  } while (choice != 0);
}
