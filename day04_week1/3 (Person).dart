abstract class Person {
  String _name;

  Person(this._name);

  set name(String name) => _name = name;
  String get name => _name;

  bool isOutstanding();
}

class Student extends Person {
  double _cgpa;

  Student(String name, this._cgpa) : super(name);

  set cgpa(double cgpa) => _cgpa = cgpa;
  double get cgpa => _cgpa;

  @override
  bool isOutstanding() {
    return _cgpa > 3.5;
  }
}

class Professor extends Person {
  int _numberOfPublications;

  Professor(String name, this._numberOfPublications) : super(name);

  set numberOfPublications(int numberOfPublications) =>
      _numberOfPublications = numberOfPublications;
  int get numberOfPublications => _numberOfPublications;

  @override
  bool isOutstanding() {
    return _numberOfPublications > 50;
  }
}

void main() {
  List<Person> persons = [
    Student("Tayyab", 3.6),
    Professor("Professor Tayyab", 45),
  ];

  for (var person in persons) {
    print("${person.name} is outstanding: ${person.isOutstanding()}");
  }

  if (persons[1] is Professor) {
    (persons[1] as Professor).numberOfPublications = 100;
    print("${persons[1].name} is outstanding: ${persons[1].isOutstanding()}");
  }
}
