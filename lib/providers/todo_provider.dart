import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo/models/todo_model.dart';
import 'package:uuid/uuid.dart';

part 'todo_provider.g.dart';

@riverpod
class Todo extends _$Todo {
  late final Uuid _uuid;
  @override
  List<TodoModel> build() {
    return [];
  }

  void addTodo(String todoTitle, String todoSubtitle) {
    final newTodo =
        TodoModel(id: _uuid.v4(), title: todoTitle, subTitle: todoSubtitle);
    state = [...state, newTodo];
  }
}
