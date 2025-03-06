import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/domain/entities/todo_model.dart';
import 'package:todo/presentation/core/theme/todo_card_color.dart';
import 'package:todo/presentation/providers/todo/todo_list_provider.dart';

class TodoDialog extends ConsumerStatefulWidget {
  const TodoDialog({super.key, required this.buttonTitle, this.todoModel});

  final String buttonTitle;
  final TodoModel? todoModel;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoDialogState();
}

class _TodoDialogState extends ConsumerState<TodoDialog> {
  late TextEditingController _controllerTodoTitle;

  @override
  void initState() {
    super.initState();
    _controllerTodoTitle = TextEditingController(
      text: widget.todoModel?.todoTitle ?? '',
    );
  }

  @override
  void dispose() {
    _controllerTodoTitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        color: Colors.white,
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 70,
                decoration: const BoxDecoration(
                  color: todoMainColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.todoModel == null ? '新しいTODO' : 'TODOを編集',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('タスク名'),
                    TextField(
                      controller: _controllerTodoTitle,
                    ),
                    const Text('期限'),
                    Row(
                      children: [
                        Checkbox(
                          value: false,
                          onChanged: (newValue) {},
                        ),
                        const Text('重要なタスク'),
                      ],
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          if (widget.todoModel == null) {
                            ref.read(todoListProvider.notifier).createTodo(
                                  _controllerTodoTitle.text,
                                  DateTime.now(),
                                  DateTime.now(),
                                  false,
                                );
                          } else {
                            // 編集の場合
                            ref.read(todoListProvider.notifier).updateTodo(
                                  _controllerTodoTitle.text,
                                  DateTime.now(),
                                  false,
                                  widget.todoModel!
                                      .id, // ここでのNull checkは安全（elseブロック内なので）
                                );
                          }
                          // ダイアログを閉じる
                          Navigator.of(context).pop();
                        },
                        child: Text(widget.buttonTitle),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
