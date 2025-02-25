import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/presentation/bottom_navigation/b_navigation_provider.dart';
import 'package:todo/presentation/pages/completed_page.dart';
import 'package:todo/presentation/pages/todo_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  static const List<Widget> pages = [
    TodoPage(),
    CompletedPage(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomNavigationNum = ref.watch(bottomNavigationProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('MY TODO'),
      ),
      body: pages[bottomNavigationNum],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomNavigationNum,
        onTap: (value) {
          ref.read(bottomNavigationProvider.notifier).state = value;
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.list_outlined), label: 'TODO'),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_box_outlined),
            label: 'complete',
          ),
        ],
        backgroundColor: Colors.green,
      ),
    );
  }
}
