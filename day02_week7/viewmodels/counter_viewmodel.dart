import 'package:flutter/material.dart';
import '../models/counter_model.dart';

class CounterViewModel extends ChangeNotifier {
  final CounterModel _counterModel = CounterModel();

  int get counter => _counterModel.counter;

  void incrementCounter() {
    _counterModel.incrementCounter();
    notifyListeners();
  }
}
