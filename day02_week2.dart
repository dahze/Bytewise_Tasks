import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Basic Widgets Example'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Text(
                  'Hello, Flutter!',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Click Me'),
                ),
                const SizedBox(height: 20),
                const Row(
                  children: <Widget>[
                    Icon(Icons.favorite, color: Colors.pink, size: 24.0),
                    SizedBox(width: 10),
                    Text('Favorite', style: TextStyle(fontSize: 20)),
                  ],
                ),
                const SizedBox(height: 20),
                Image.network(
                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
                  height: 150,
                ),
                const SizedBox(height: 20),
                const Placeholder(
                  fallbackHeight: 100,
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Text(
                    'This is a container with some padding and rounded corners.',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(height: 20),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('Column Item 1'),
                    Text('Column Item 2'),
                    Text('Column Item 3'),
                  ],
                ),
                const SizedBox(height: 20),
                const Row(
                  children: <Widget>[
                    Expanded(child: Text('Row Item 1')),
                    Expanded(child: Text('Row Item 2')),
                    Expanded(child: Text('Row Item 3')),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
