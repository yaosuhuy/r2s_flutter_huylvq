import 'dart:io';
import '../../session4/exercise/student.dart';
import '../../session4/exercise/teacher.dart';
import 'person.dart';

void inputPerson(List<Person> persons, int n) {
  for (int i = 0; i < n; i++) {
    do {
      print("Enter person's type (student/teacher): ");
      String type = stdin.readLineSync()!;

      if (type.toLowerCase() == "student" || type.toLowerCase() == "teacher") {
        if (type == "student") {
          Student student = Student("", "", "", "", "", 0, 0);
          student.inputPerson();
          persons.add(student);
        } else {
          Teacher teacher = Teacher("", "", "", "", 0, 0);
          teacher.inputPerson();
          persons.add(teacher);
        }

        break;
      } else {
        print("Invalid type");
      }
    } while (true);
  }
}

void updateStudentData(List<Person> persons, String studentID) {
  for (Person person in persons) {
    // "is" is used to check the type of an object
    if (person is Student && person.studentID == studentID) {
      person.inputPerson();
      break;
    }
  }
}

void displayTeacherWithCondition(List<Person> persons) {
  for (Person person in persons) {
    if (person is Teacher && person.calculateSalary() > 1000) {
      person.displayPerson();
    }
  }
}

void reportStudentsPassedCourse(List<Person> persons) {
  for (Person person in persons) {
    if (person is Student && person.calculateFinalMark() >= 6) {
      person.displayPerson();
    }
  }
}

void main() {
  List<Person> persons = [];
  int choice;
  do {
    print("-----------------Person Management-----------------");
    print("1. Input person's data");
    print("2. Update student's data (by entering student ID)");
    print(r"3. Display teacher that have salary > 1000$");
    print("4. Report the students that passed the course (final mark >= 6)");
    print("0. Exit");
    print("Enter your choice: ");
    choice = int.parse(stdin.readLineSync()!);
    switch (choice) {
      case 1:
        print("Enter the number of persons: ");
        int n = int.parse(stdin.readLineSync()!);
        inputPerson(persons, n);
        break;
      case 2:
        print("Enter student ID: ");
        String studentID = stdin.readLineSync()!;
        updateStudentData(persons, studentID);
        break;
      case 3:
        displayTeacherWithCondition(persons);
        break;
      case 4:
        reportStudentsPassedCourse(persons);
        break;
      default:
        print("Invalid choice");
    }
  } while (choice != 0);
}
