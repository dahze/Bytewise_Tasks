import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:day03_week10/main.dart';
import 'package:provider/provider.dart';
import 'package:day03_week10/counter.dart';

void main() {
  testWidgets('Counter increments when button is tapped',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => CounterModel(),
        child: const MyApp(),
      ),
    );

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
