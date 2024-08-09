import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/counter_view.dart';
import 'viewmodels/counter_viewmodel.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CounterViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter MVVM Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CounterView(),
    );
  }
}
