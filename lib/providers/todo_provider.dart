import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo/models/todo_model.dart';
import 'package:uuid/uuid.dart';

part 'todo_provider.g.dart';

@riverpod
class Todo extends _$Todo {
  final Uuid _uuid = const Uuid();
  @override
  List<TodoModel> build() {
    return [];
  }

  void addTodo(String todoTitle, String todoSubtitle) {
    final newTodo =
        TodoModel(id: _uuid.v4(), title: todoTitle, subTitle: todoSubtitle);
    state = [...state, newTodo];
  }

  void toggleTodoChecked(String id) {
    state = [
      for (final todo in state)
        if (id == todo.id) todo.copyWith(isChecked: !todo.isChecked) else todo
    ];
  }

  void deleteTodo(String id) {
    state = state.where((todo) => todo.id != id).toList();
  }
}
