import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CounterScreen extends HookWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final count = useState(0);
    return Scaffold(
      body: Center(
        child: Text(
          '${count.value}',
          style: const TextStyle(fontSize: 50),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          count.value = count.value + 1;
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
