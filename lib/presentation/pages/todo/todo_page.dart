import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/presentation/core/appbar/custom_appbar.dart';
import 'package:todo/presentation/pages/todo/widgets/todo_card.dart';
import 'package:todo/presentation/providers/todo_list_provider.dart';

class TodoPage extends ConsumerWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoListAsync = ref.watch(todoListProvider);
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'マイタスク',
        subTitle: 'タスクが3件残っています',
      ),
      body: todoListAsync.when(
        data: (todoListData) {
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            itemCount: todoListData.length,
            itemBuilder: (context, index) {
              final todoList = todoListData[index];
              return TodoCard(
                todoTitle: todoList.todoTitle,
                dueDate: todoList.dueDate,
              );
            },
          );
        },
        error: (error, _) => Center(child: Text('$error')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('TODO追加'),
              );
            },
          );
        },
      ),
    );
  }
}


