// ignore_for_file: prefer_final_fields

import 'dart:math';

class Box<T> {
  List<T> _items = [];

  void add(T item) {
    _items.add(item);
  }

  bool isEmpty() {
    return _items.isEmpty;
  }

  T? drawItem() {
    if (isEmpty()) {
      return null;
    }

    Random random = Random();
    int index = random.nextInt(_items.length);
    return _items[index];
  }
}

void main() {
  Box<String> stringBox = Box<String>();
  stringBox.add("Tayyab");
  stringBox.add("Saad");
  stringBox.add("Faaiz");

  print("Drawing items from stringBox:");
  for (int i = 0; i < 5; i++) {
    var item = stringBox.drawItem();
    if (item != null) {
      print("Item drawn: $item");
    }
  }

  Box<int> intBox = Box<int>();
  intBox.add(21);
  intBox.add(57);
  intBox.add(49);

  print("\nDrawing items from intBox:");
  for (int i = 0; i < 5; i++) {
    var item = intBox.drawItem();
    if (item != null) {
      print("Item drawn: $item");
    }
  }

  Box<double> emptyBox = Box<double>();
  var item = emptyBox.drawItem();
  if (item == null) {
    print("Item drawn: null (Box is empty)");
  }
}
