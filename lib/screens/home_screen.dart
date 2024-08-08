import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/providers/tab_provider.dart';
import 'package:todo/providers/todo_provider.dart';
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

  final _titleTextController = TextEditingController();
  final _subtitleTextController = TextEditingController();

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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: _titleTextController,
                        decoration: const InputDecoration(
                          hintText: 'TODO',
                          hintStyle: TextStyle(color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2.0)),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: _subtitleTextController,
                        decoration: const InputDecoration(
                          hintText: '内容',
                          hintStyle: TextStyle(color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2.0)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        ref.read(todoProvider.notifier).addTodo(
                            _titleTextController.text,
                            _subtitleTextController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text(
                        '追加',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
