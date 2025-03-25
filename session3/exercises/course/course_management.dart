import 'dart:io';

import 'course.dart';

void input({required Course course}) {
  while (true) {
    print("Enter course code: ");
    course.code = stdin.readLineSync()!;

    if (RegExp(r'^FW\d{3}$').hasMatch(course.code)) {
      break;
    } else {
      print("Invalid course code. Course code must be in the format FWXXX");
    }
  }

  print("Enter course name: ");
  course.name = stdin.readLineSync()!;

  while (true) {
    try {
      print("Enter course duration: ");
      course.duration = double.parse(stdin.readLineSync()!);
      break;
    } catch (e) {
      print("Invalid input: Duration must be a number");
    }
  }

  while (true) {
    print("Enter course status: ");
    course.status = stdin.readLineSync()!;

    if (course.status.toLowerCase() == "active" ||
        course.status.toLowerCase() == "inactive") {
      break;
    } else {
      print(
        "Invalid course status. Course status must be either Active or Inactive",
      );
    }
  }

  while (true) {
    print("Enter course flag: ");
    course.flag = stdin.readLineSync()!;
    if (course.flag.toLowerCase() == "optional" ||
        course.flag.toLowerCase() == "mandatory" ||
        course.flag.toLowerCase() == "N/A") {
      break;
    } else {
      print("Invalid course flag. Course flag must be either new or old");
    }
  }
}

void output({required Course course}) {
  print("Course code: ${course.code}");
  print("Course name: ${course.name}");
  print("Course duration: ${course.duration}");
  print("Course status: ${course.status}");
  print("Course flag: ${course.flag}");
  print("-------------------------------");
}

void find(List<Course> courses, String type, dynamic data) {
  for (var course in courses) {
    switch (type) {
      case "code":
        if (course.code == data) {
          output(course: course);
        } else {
          print("Course not found");
        }
        break;
      case "name":
        List<Course> foundCourses = [];
        if (course.name.toLowerCase().contains(data.toLowerCase())) {
          foundCourses.add(course);
        }
        if (foundCourses.isNotEmpty) {
          for (var course in foundCourses) {
            output(course: course);
          }
        } else {
          print("Course not found");
        }
        break;
      case "duration":
        List<Course> foundCourses = [];
        if (course.duration == data) {
          foundCourses.add(course);
        }
        if (foundCourses.isNotEmpty) {
          for (var course in foundCourses) {
            output(course: course);
          }
        } else {
          print("Course not found");
        }
        break;
      case "status":
        List<Course> foundCourses = [];
        if (course.status == data) {
          foundCourses.add(course);
        }
        if (foundCourses.isNotEmpty) {
          for (var course in foundCourses) {
            output(course: course);
          }
        } else {
          print("Course not found");
        }
        break;
      case "flag":
        List<Course> foundCourses = [];
        if (course.flag == data) {
          foundCourses.add(course);
        }
        if (foundCourses.isNotEmpty) {
          for (var course in foundCourses) {
            output(course: course);
          }
        } else {
          print("Course not found");
        }
        break;
      default:
        print("Invalid type");
    }
  }
}

void main() {
  List<Course> courses = [];
  int choice;
  do {
    print("1. Add course");
    print("2. Display optional course");
    print("3. Exit");
    print("Enter your choice: ");
    choice = int.parse(stdin.readLineSync()!);
    switch (choice) {
      case 1:
        var course = Course();
        input(course: course);
        courses.add(course);
        break;
      case 2:
        for (Course course in courses) {
          if (course.flag.toLowerCase() == "optional") {
            output(course: course);
          }
        }
      case 3:
        print('Enter attribute to search by: ');
        print("1. Code");
        print("2. Name");
        print("3. Duration");
        print("4. Status");
        print("5. Flag");
        int attribute = int.parse(stdin.readLineSync()!);
        print('Enter value to search for: ');
        String value = stdin.readLineSync()!;
        switch (attribute) {
          case 1:
            find(courses, "code", value);
            break;
          case 2:
            find(courses, "name", value);
            break;
          case 3:
            find(courses, "duration", double.parse(value));
            break;
          case 4:
            find(courses, "status", value);
            break;
          case 5:
            find(courses, "flag", value);
            break;
          default:
            print("Invalid attribute");
        }
        break;
    }
  } while (choice != 0);
}
