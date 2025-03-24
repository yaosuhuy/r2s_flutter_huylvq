import 'student.dart';
void printStudentDetails(Student student){
  print("Name: ${student.name}");
  print("Mark 1: ${student.mark1}");
  print("Mark 2: ${student.mark2}");
  print("Mark 3: ${student.mark3}");
  print("Total: ${student.total()}");
  print("Average: ${student.average()}");
}
void main(){
  var student1 =  Student();
  var student2 =  Student();
  var student3 =  Student();

  student1.name = 'John';
  student1.mark1 = 80;
  student1.mark2 = 60;
  student1.mark3 = 70;

  student2.name = 'Jane';
  student2.mark1 = 90;
  student2.mark2 = 60;
  student2.mark3 = 80;

  student3.name = 'Smith';
  student3.mark1 = 70;
  student3.mark2 = 60;
  student3.mark3 = 90;

  printStudentDetails(student1);
  printStudentDetails(student2);
  printStudentDetails(student3);
} 