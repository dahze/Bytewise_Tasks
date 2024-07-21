import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic Animation Concepts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _translationAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _opacityAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _translationAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(1.5, 0))
            .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Animation Concepts'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FadeTransition(
              opacity: _opacityAnimation,
              child: SlideTransition(
                position: _translationAnimation,
                child: Container(
                  width: 100,
                  height: 100,
                  color: Colors.blue,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startAnimation,
              child: const Text('Start Animation'),
            ),
          ],
        ),
      ),
    );
  }
}
