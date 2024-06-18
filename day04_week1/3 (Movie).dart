abstract class Movie {
  late int _id, _days;
  late String _title;

  Movie(this._id, this._title, this._days);

  int get id => _id;
  String get title => _title;
  int get days => _days;

  set id(int id) => _id = id;
  set title(String title) => _title = title;
  set days(int days) => _days = days;

  num calcLateFees(int daysLate);
  bool equals(Movie movie2) {
    return _id == movie2.id && _title == movie2.title && _days == movie2.days;
  }

  void display() {
    print("Title: $title");
    print("ID: $_id");
    print("Days Rented: $_days");
  }
}

class Action extends Movie {
  Action(int id, String title, int days) : super(id, title, days);

  @override
  num calcLateFees(int daysLate) {
    return daysLate * 3;
  }
}

class Comedy extends Movie {
  Comedy(int id, String title, int days) : super(id, title, days);

  @override
  num calcLateFees(int daysLate) {
    return daysLate * 2.50;
  }
}

class Drama extends Movie {
  Drama(int id, String title, int days) : super(id, title, days);

  @override
  num calcLateFees(int daysLate) {
    return daysLate * 2;
  }
}

void main() {
  Movie movie1 = Action(1, "End of Watch", 9);
  movie1.display();
  print("Late Fee: ${movie1.calcLateFees(5)}\n");

  Movie movie2 = Comedy(103, "Demolition", 5);
  movie2.display();
  print("Late Fee: ${movie2.calcLateFees(1)}\n");

  Movie movie3 = Drama(34, "First Man", 7);
  movie3.display();
  print("Late Fee: ${movie2.calcLateFees(3)}\n");

  if (movie1 is Action) {
    movie1.id = 2;
    print("ID of '${movie1.title}' changed to '${movie1.id}'.\n");
  }

  (movie1.equals(movie2)) ? print("Equivalent.") : print("Not Equivalent.");
}
