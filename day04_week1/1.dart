// ignore_for_file: unused_field

class Person {
  late String _name, _address, _phoneNumber, _email;

  set name(String name) => _name = name;
  set address(String address) => _address = address;
  set phoneNumber(String phoneNumber) => _phoneNumber = phoneNumber;
  set email(String email) => _email = email;

  String get name => _name;
  String get address => _address;
  String get phoneNumber => _phoneNumber;
  String get email => _email;
}

class Student extends Person {
  String? _status;
}

class Employee extends Person {
  late int _office, _salary;
  late String _date;

  set office(int office) => _office = office;
  set salary(int salary) => _salary = salary;
  void setDate(int day, int month, int year) {
    _date = "$day/$month/$year";
  }

  int get office => _office;
  int get salary => _salary;
  String get date => _date;
}

class Faculty extends Employee {
  int? _officeStart, _officeEnd;
  String? _rank;

  Faculty(int officeStart, int officeEnd, String rank) {
    _officeStart = officeStart;
    _officeEnd = officeEnd;
    _rank = rank;
  }

  void facultyDisplay() {
    print("\nFaculty:");
    print("Name: $name");
    print("Rank: $_rank");
    print("Address: $address");
    print("Phone Number: $phoneNumber");
    print("Email Address: $email");
    print("Office: $office");
    print("Salary: $salary");
    print("Date Hired: $date");
    print("Office Hours: $_officeStart-$_officeEnd");
  }
}

class Staff extends Employee {
  late String _title;

  Staff(String title) {
    _title = title;
  }

  void staffDisplay() {
    print("\nStaff:");
    print("Name: $name");
    print("Title: $_title");
    print("Address: $address");
    print("Phone Number: $phoneNumber");
    print("Email Address: $email");
    print("Office: $office");
    print("Salary: $salary");
    print("Date Hired: $date");
  }
}

void main() {
  Faculty facultyMember = Faculty(9, 5, "Lecturer");
  facultyMember.name = "Tayyab Shehzad";
  facultyMember.address = "Islamabad";
  facultyMember.phoneNumber = "03334444555";
  facultyMember.email = "tayyab@gmail.com";
  facultyMember.office = 1;
  facultyMember.salary = 50000;
  facultyMember.setDate(4, 4, 2024);
  facultyMember.facultyDisplay();

  Staff staffMember = Staff("Network Administrator");
  staffMember.name = "Also Tayyab";
  staffMember.address = "Lahore";
  staffMember.phoneNumber = "03214569847";
  staffMember.email = "also@example.com";
  staffMember.office = 36;
  staffMember.salary = 75000;
  staffMember.setDate(2, 2, 2024);
  staffMember.staffDisplay();
}
