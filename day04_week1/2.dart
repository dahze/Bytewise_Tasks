class Student {
  late String _name;
  late List<num> _resultArray;
  num _average = 0;

  Student() {
    _name = 'N/A';
    _resultArray = [0];
    _average = 0;
  }

  Student.nameConst(this._name);
  Student.allConst(this._name, this._resultArray);

  set name(String name) => _name = name;
  set array(List<num> array) => _resultArray = array;

  String get name => _name;
  List<num> get array => _resultArray;
  num getAverage() {
    for (int i = 0; i < 5; i++) {
      _average += _resultArray[i];
    }

    _average /= 5;
    return _average;
  }

  void compareAverage(num average2) {
    _average = getAverage();
    if (_average > average2) {
      print(
          "The average of Student 1 ($_average) is greater than the average of Student 2 ($average2).");
    } else if (_average < average2) {
      print(
          "The average of Student 2 ($average2) is greater than the average of Student 1 ($_average).");
    } else {
      "The averages of both the students are equal.";
    }
  }
}

void main() {
  Student student1 = Student.nameConst("Tayyab");
  List<num> resultArray1 = [78.25, 85, 74.5, 63, 91.5];
  student1.array = resultArray1;

  List<num> resultArray2 = [72, 67.5, 52, 97, 72.75];
  Student student2 = Student.allConst("Faaiz", resultArray2);

  student1.compareAverage(student2.getAverage());
}
