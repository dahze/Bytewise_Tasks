import 'package:flutter/material.dart';
import 'custom.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Widgets Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Widgets Demo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const <Widget>[
          CustomCard(
            title: 'Card 1',
            subtitle: 'This is the first card',
            icon: Icons.star,
            color: Colors.blue,
          ),
          CustomCard(
            title: 'Card 2',
            subtitle: 'This is the second card',
            icon: Icons.favorite,
            color: Colors.red,
          ),
          CustomCard(
            title: 'Card 3',
            subtitle: 'This is the third card',
            icon: Icons.thumb_up,
            color: Colors.green,
          ),
        ],
      ),
    );
  }
}
