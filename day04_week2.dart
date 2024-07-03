// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _gestureText = 'No Gesture detected';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Input Interaction in Flutter'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(() {
                    _gestureText = 'Tapped';
                  });
                },
                child: Container(
                  color: Colors.blue,
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _gestureText,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    _gestureText = 'InkWell Tapped';
                  });
                },
                child: Container(
                  color: Colors.green,
                  padding: const EdgeInsets.all(16.0),
                  child: const Text(
                    'Tap me',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter your name',
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
