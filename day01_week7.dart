import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi Theme Demo',
      theme: _isDarkTheme ? darkTheme : lightTheme,
      home: MyHomePage(
        isDarkTheme: _isDarkTheme,
        onThemeChanged: (isDark) {
          setState(() {
            _isDarkTheme = isDark;
          });
        },
      ),
    );
  }
}

final ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.blue,
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    color: Colors.blue,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.blue,
  ),
);

final ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.blue,
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    color: Colors.blueGrey,
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.blueGrey,
  ),
);

class MyHomePage extends StatelessWidget {
  final bool isDarkTheme;
  final ValueChanged<bool> onThemeChanged;

  const MyHomePage(
      {super.key, required this.isDarkTheme, required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Multi Theme Demo'),
        actions: [
          Switch(
            value: isDarkTheme,
            onChanged: onThemeChanged,
            activeColor: Colors.white,
          ),
        ],
      ),
      body: const Center(
        child: Text('Hello, Flutter!'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
