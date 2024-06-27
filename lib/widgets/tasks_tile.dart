import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Buy Milk'),
      trailing: TaskCheckbox(),
    );
  }
}

class TaskCheckbox extends StatefulWidget {
  @override
  State<TaskCheckbox> createState() => _TaskCheckboxState();
}

class _TaskCheckboxState extends State<TaskCheckbox> {
  bool? isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: isChecked,
      onChanged: (newValue) {
        setState(() {
          isChecked = newValue;
        });
      },
    );
  }
}
