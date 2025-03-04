import 'package:flutter/material.dart';
import 'package:todo/presentation/core/appbar/custom_appbar.dart';

class CompletedPage extends StatelessWidget {
  const CompletedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(title: '完了タスク'),
      body: Center(
        child: Text('完了したTODOをここに表示'),
      ),
    );
  }
}
