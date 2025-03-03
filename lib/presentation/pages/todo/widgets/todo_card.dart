import 'package:flutter/material.dart';
import 'package:todo/presentation/core/theme/todo_card_color.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({
    super.key,
    required this.todoTitle,
    required this.dueDate,
  });

  final String todoTitle;
  final DateTime dueDate;

  @override
  Widget build(BuildContext context) {
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
              Text(todoTitle),
              Text('$dueDate'),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit_note_outlined),
            visualDensity: VisualDensity.compact,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.delete_outlined),
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}
