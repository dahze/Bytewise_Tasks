import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/counter_viewmodel.dart';
import '../widgets/custom_button.dart';

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    final counterViewModel = Provider.of<CounterViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('MVVM Counter Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${counterViewModel.counter}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            CustomButton(
              onPressed: counterViewModel.incrementCounter,
              label: "Increment",
            ),
          ],
        ),
      ),
    );
  }
}
