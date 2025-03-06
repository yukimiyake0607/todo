import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo/domain/entities/todo_model.dart';
import 'package:todo/presentation/core/theme/todo_card_color.dart';
import 'package:todo/presentation/pages/todo/widgets/todo_dialog.dart';
import 'package:todo/presentation/providers/completed/completed_list_provider.dart';
import 'package:todo/presentation/providers/todo/todo_list_provider.dart';

class TodoCard extends ConsumerStatefulWidget {
  const TodoCard({
    super.key,
    required this.todoModel,
  });

  final TodoModel todoModel;

  @override
  ConsumerState<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends ConsumerState<TodoCard> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.todoModel.isCompleted;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: _isChecked == false
            ? Colors.white
            : completedCardColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: _isChecked == false
                ? todoMainColor.withOpacity(0.1)
                : completedCardColor.withOpacity(0.1),
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
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
            child: Container(
              width: 5,
              color: _isChecked == false
                  ? todoMainColor
                  : completedCardColor.withOpacity(0.05),
            ),
          ),
          Checkbox(
            value: _isChecked,
            onChanged: (newValue) async {
              // 一時的に状態を更新せず、0.5秒後に更新する
              await Future.delayed(const Duration(milliseconds: 200), () {
                if (mounted) {
                  setState(() {
                    // nullが返ってくることを考慮してデフォでfalseを指定
                    _isChecked = newValue ?? false;
                  });
                }
              });

              // 反対のリストに移動する処理
              if (newValue == true) {
                // todoが完了したと判断
              } else {
                // todoをTodoListに戻す
              }
            },
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.todoModel.todoTitle),
              widget.todoModel.dueDate != null
                  ? Text(DateFormat('yyyy年MM月dd日')
                      .format(widget.todoModel.dueDate!))
                  : const SizedBox.shrink(),
            ],
          ),

          // Todoタイトルとボタン間に余白
          const Spacer(),

          // 編集機能はTodoPageのみ
          if (_isChecked == false)
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return TodoDialog(
                      buttonTitle: '編集',
                      todoModel: widget.todoModel,
                    );
                  },
                );
              },
              icon: const Icon(Icons.edit_note_outlined),
              visualDensity: VisualDensity.compact,
            ),

          // 削除ボタン：両方
          IconButton(
            onPressed: () {
              if (_isChecked == false) {
                ref
                    .read(todoListProvider.notifier)
                    .deleteTodo(widget.todoModel.id);
              } else {
                ref
                    .read(completedListProvider.notifier)
                    .deleteCompletedTodo(widget.todoModel.id);
              }
            },
            icon: const Icon(Icons.delete_outlined),
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}
