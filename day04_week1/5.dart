class Job {
  String _desig = '';
  int _salary = 0, _id = 0;

  Job(this._desig, this._salary, this._id);

  set desig(String desig) => _desig = desig;
  set salary(int salary) => _salary = salary;
  set id(int id) => _id = id;

  String get desig => _desig;
  int get salary => _salary;
  int get id => _id;

  bool greater() {
    return _salary > 50000;
  }
}

class Employee {
  late String _name, _address, _phoneNumber, _email;

  Employee(this._name, this._address, this._phoneNumber, this._email);

  Job obj = Job("Database Engineer", 95000, 105);

  void display() {
    print("Name: $_name");
    print("ID: ${obj.id}");
    print("Designation: ${obj.desig}");
    print("Address: $_address");
    print("Phone Number: $_phoneNumber");
    print("Email Address: $_email");
    print("Salary: ${obj.salary}\n");

    obj.greater()
        ? print("The employee's salary is greater than 50000.")
        : print("The employee's salary is less than 50000.");
  }
}

void main() {
  Employee emp1 =
      Employee("Tayyab", "Islamabad", "03334567890", "tayyab@gmail.com");
  emp1.display();
}
