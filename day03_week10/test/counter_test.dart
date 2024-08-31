import 'package:flutter_test/flutter_test.dart';
import 'package:day03_week10/counter.dart';

void main() {
  test('Counter value should increment', () {
    final model = CounterModel();

    model.increment();

    expect(model.counter, 1);
  });
}
