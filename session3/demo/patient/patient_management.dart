import 'patient.dart';

void printPatientInfo(Patient patient) {
  print("Name: ${patient.name}");
  print("Age: ${patient.age}");
  print("Disease: ${patient.disease}");
}
void main() {
  Patient patient = Patient("Huy", 22, "Covid-19");
  printPatientInfo(patient);
}