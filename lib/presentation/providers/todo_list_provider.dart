import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo/domain/entities/todo_model.dart';
import 'package:uuid/uuid.dart';

part 'todo_list_provider.g.dart';

@riverpod
class TodoList extends _$TodoList {
  @override
  FutureOr<List<TodoModel>> build() {
    return [];
  }

  Future<void> createTodo(
    String todoTitle,
    DateTime? dueDate,
    DateTime createdDate,
    bool important,
  ) async {
    state = const AsyncValue.loading();

    // 新規TODOを作成
    final newTodo = TodoModel(
      id: const Uuid().v4(),
      todoTitle: todoTitle,
      dueDate: dueDate,
      createdDate: createdDate,
      important: important,
    );

    final currentTodos = state.valueOrNull ?? [];
    state = AsyncValue.data([...currentTodos, newTodo]);
  }

  Future<void> deleteTodo(String id) async {
    final currentTodos = state.valueOrNull ?? [];
    final updateTodos = currentTodos.where((todo) => todo.id != id).toList();

    state = AsyncValue.data(updateTodos);
  }
}
