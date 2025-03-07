import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/presentation/core/appbar/custom_appbar.dart';
import 'package:todo/presentation/pages/todo/widgets/todo_card.dart';
import 'package:todo/presentation/pages/todo/widgets/todo_dialog.dart';
import 'package:todo/presentation/providers/todo/todo_list_provider.dart';

class TodoPage extends ConsumerStatefulWidget {
  const TodoPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoPageState();
}

class _TodoPageState extends ConsumerState<TodoPage> {
  @override
  Widget build(BuildContext context) {
    final todoListAsync = ref.watch(todoListProvider);
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'マイタスク',
        subTitle: 'タスクが3件残っています',
      ),
      body: todoListAsync.when(
        data: (todoList) {
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            itemCount: todoList.length,
            itemBuilder: (context, index) {
              final todo = todoList[index];
              return TodoCard(
                todoModel: todo,
                key: ValueKey(todo.id),
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
              return const TodoDialog(buttonTitle: '追加');
            },
          );
        },
      ),
    );
  }
}
