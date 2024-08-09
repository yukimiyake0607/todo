import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/providers/todo_provider.dart';

class TodoScreen extends ConsumerWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoListAsync = ref.watch(todoProvider);
    return todoListAsync.when(
      data: (todoList) => ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            final todo = todoList[index];
            return Dismissible(
              key: Key(todo.id),
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.all(20),
                child: const Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
              ),
              onDismissed: (direction) {
                ref.read(todoProvider.notifier).deleteTodo(todo.id);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text('${todo.title} を削除しました'),
                  action: SnackBarAction(
                      label: '元に戻す',
                      onPressed: () {
                        ref
                            .read(todoProvider.notifier)
                            .addTodo(todo.title, todo.subTitle);
                      }),
                ));
              },
              child: ListTile(
                leading: Checkbox(
                  value: todo.isChecked,
                  onChanged: (value) {
                    ref.read(todoProvider.notifier).toggleTodoChecked(todo.id);
                  },
                ),
                title: Text(todo.title),
                subtitle: Text(todo.subTitle),
              ),
            );
          }),
      error: (error, stack) => Center(
          child: Text(
        'エラーが発生しました:$error',
        style: Theme.of(context).textTheme.displaySmall,
      )),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
