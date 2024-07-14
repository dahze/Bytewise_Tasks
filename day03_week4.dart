// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adaptive and Responsive Design',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ResponsiveScreen(),
    );
  }
}

class ResponsiveScreen extends StatelessWidget {
  const ResponsiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adaptive and Responsive Design'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: Container(color: Colors.red),
                ),
                Flexible(
                  flex: 2,
                  child: Container(color: Colors.green),
                ),
                Flexible(
                  flex: 3,
                  child: Container(color: Colors.blue),
                ),
              ],
            );
          } else {
            return Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Container(color: Colors.red),
                ),
                Expanded(
                  flex: 2,
                  child: Container(color: Colors.green),
                ),
                Expanded(
                  flex: 1,
                  child: Container(color: Colors.blue),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
