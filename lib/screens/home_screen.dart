import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/providers/tab_provider.dart';
import 'package:todo/screens/completed_screen.dart';
import 'package:todo/screens/todo_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: 2, vsync: this);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODOリスト'),
        bottom: TabBar(
          tabs: const [
            Tab(text: '未完了'),
            Tab(text: '完了'),
          ],
          indicatorColor: Colors.grey,
          controller: _tabController,
          onTap: (value) {
            ref.read(tabProvider.notifier).update(value);
          },
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          TodoScreen(),
          CompletedScreen(),
        ],
      ),
    );
  }
}
