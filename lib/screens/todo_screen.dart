import 'package:flutter/material.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Checkbox(
              value: false,
              onChanged: (value) {
                value = !value!;
              },
            ),
            title: Text('買い物'),
            subtitle: Text('牛乳、バター'),
          );
        });
  }
}
