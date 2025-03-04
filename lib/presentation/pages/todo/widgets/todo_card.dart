import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/domain/entities/todo_model.dart';
import 'package:todo/presentation/core/theme/todo_card_color.dart';
import 'package:todo/presentation/pages/todo/widgets/todo_dialog.dart';
import 'package:todo/presentation/providers/todo_list_provider.dart';

class TodoCard extends ConsumerWidget {
  const TodoCard({
    super.key,
    required this.todoModel,
  });

  final TodoModel todoModel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: todoMainColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: todoCardBorderColor,
        ),
      ),
      child: Row(
        children: [
          ClipRRect(
            // 重要タスクの場合true
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Container(
              width: 5,
              color: todoMainColor,
            ),
          ),
          Checkbox(
            value: true,
            onChanged: (newValue) {},
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(todoModel.todoTitle),
              Text('${todoModel.dueDate}'),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return TodoDialog(
                    buttonTitle: '編集',
                    todoModel: todoModel,
                  );
                },
              );
            },
            icon: const Icon(Icons.edit_note_outlined),
            visualDensity: VisualDensity.compact,
          ),
          IconButton(
            onPressed: () {
              ref.read(todoListProvider.notifier).deleteTodo(todoModel.id);
            },
            icon: const Icon(Icons.delete_outlined),
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}
