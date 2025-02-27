import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/presentation/bottom_navigation/bottom_navigation_provider.dart';
import 'package:todo/presentation/bottom_navigation/bottom_navigation.dart';
import 'package:todo/presentation/pages/completed_page.dart';
import 'package:todo/presentation/pages/profile_page.dart';
import 'package:todo/presentation/pages/todo_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomNavigationNum = ref.watch(bottomNavigationProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('MY TODO')),
      body: IndexedStack(
        index: bottomNavigationNum,
        children: const [
          TodoPage(),
          CompletedPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
