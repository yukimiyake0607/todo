import 'package:flutter/material.dart';

class TaskTile extends StatefulWidget {
  const TaskTile({super.key});

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  // プロパティ
  bool isChecked = false;

  // override
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        'This is a task.',
        style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null),
      ),
      trailing: TaskCheckbox(
        isChecked: isChecked,
        onCheckedChanged: (value) {
          setState(() {
            isChecked = value;
          });
        },
      ),
    );
  }
}

class TaskCheckbox extends StatelessWidget {
  final bool isChecked;
  final dynamic onCheckedChanged;

  TaskCheckbox({required this.isChecked, required this.onCheckedChanged});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isChecked,
      onChanged: onCheckedChanged,
    );
  }
}
