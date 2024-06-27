import 'package:flutter/material.dart';

class TaskTile extends StatefulWidget {
  const TaskTile({super.key});

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  // プロパティ
  bool isChecked = false;
  // メソッド
  TextDecoration? getLineThrough() {
    if (isChecked == true) {
      return TextDecoration.lineThrough;
    } else {
      return null;
    }
  }

  // override
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('This is a task.',
          style: TextStyle(decoration: getLineThrough())),
      trailing: Checkbox(
        value: isChecked,
        onChanged: (newValue) {
          setState(() {
            isChecked = newValue!;
          });
        },
      ),
    );
  }
}






