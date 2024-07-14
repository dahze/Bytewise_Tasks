import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Completion(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CompletionScreen(),
    );
  }
}

class Completion extends ChangeNotifier {
  double _progress = 0.0;

  double get progress => _progress;

  void increment() {
    if (_progress < 1.0) {
      _progress += 0.1;
      notifyListeners();
    }
  }

  void reset() {
    _progress = 0.0;
    notifyListeners();
  }
}

class CompletionScreen extends StatelessWidget {
  const CompletionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Completion Bar'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Consumer<Completion>(
                builder: (context, completion, child) {
                  return LinearProgressIndicator(
                    value: completion.progress,
                    backgroundColor: Colors.grey[300],
                    color: Colors.blue,
                    minHeight: 20,
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Consumer<Completion>(
              builder: (context, completion, child) {
                return Text(
                  '${(completion.progress * 100).toInt()}%',
                  style: const TextStyle(fontSize: 24),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () => context.read<Completion>().increment(),
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            onPressed: () => context.read<Completion>().reset(),
            tooltip: 'Reset',
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
