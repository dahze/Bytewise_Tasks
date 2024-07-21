import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Simple Animations Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const DetailScreen()),
            );
          },
          child: Hero(
            tag: 'hero-animation',
            child: Container(
              width: 100,
              height: 100,
              color: Colors.blue,
              child: const Icon(Icons.star, color: Colors.white, size: 50),
            ),
          ),
        ),
      ),
    );
  }
}

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 50, end: 150).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: 'hero-animation',
              child: Container(
                width: 200,
                height: 200,
                color: Colors.blue,
                child: const Icon(Icons.star, color: Colors.white, size: 100),
              ),
            ),
            const SizedBox(height: 50),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Container(
                  width: _animation.value,
                  height: _animation.value,
                  color: Colors.red,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
