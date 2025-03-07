import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/presentation/core/appbar/custom_appbar.dart';
import 'package:todo/presentation/pages/todo/widgets/todo_card.dart';
import 'package:todo/presentation/providers/completed/completed_list_provider.dart';

class CompletedPage extends ConsumerWidget {
  const CompletedPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completedListAsync = ref.watch(completedListProvider);
    return Scaffold(
      appBar: const CustomAppBar(title: '完了タスク'),
      body: completedListAsync.when(
        data: (completedList) {
          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            itemCount: completedList.length,
            itemBuilder: (context, index) {
              final completedTodo = completedList[index];
              return TodoCard(
                todoModel: completedTodo,
                key: ValueKey(completedTodo.id),
              );
            },
          );
        },
        error: (error, _) => Center(child: Text('$error')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
