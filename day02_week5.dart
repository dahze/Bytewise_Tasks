import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Implicit Animations Demo',
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

class _MyHomePageState extends State<MyHomePage> {
  bool _isExpanded = false;

  void _toggleContainer() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Implicit Animations Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedContainer(
              width: _isExpanded ? 200.0 : 100.0,
              height: _isExpanded ? 200.0 : 100.0,
              color: _isExpanded ? Colors.white : Colors.blue,
              alignment: _isExpanded
                  ? Alignment.center
                  : AlignmentDirectional.topCenter,
              duration: const Duration(seconds: 1),
              child: const FlutterLogo(size: 75),
            ),
            const SizedBox(height: 20),
            AnimatedOpacity(
              opacity: _isExpanded ? 1.0 : 0.5,
              duration: const Duration(seconds: 1),
              child: ElevatedButton(
                onPressed: _toggleContainer,
                child: const Text('Toggle Animation'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
