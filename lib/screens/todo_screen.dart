import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/providers/todo_provider.dart';

class TodoScreen extends ConsumerWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoList = ref.watch(todoProvider);
    return ListView.builder(
        itemCount: todoList.length,
        itemBuilder: (context, index) {
          final todo = todoList[index];
          return ListTile(
            leading: Checkbox(
              value: todo.isChecked,
              onChanged: (value) {
                value = !value!;
              },
            ),
            title: Text(todo.title),
            subtitle: Text(todo.subTitle),
          );
        });
  }
}
