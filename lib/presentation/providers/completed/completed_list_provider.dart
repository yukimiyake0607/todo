import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo/domain/entities/todo_model.dart';

part 'completed_list_provider.g.dart';

@riverpod
class CompletedList extends _$CompletedList {
  @override
  FutureOr<List<TodoModel>> build() {
    return [
      TodoModel(
        id: '1',
        todoTitle: '仮',
        dueDate: DateTime.now(),
        createdDate: DateTime.now(),
        important: false,
        isCompleted: true,
      ),
      TodoModel(
        id: '2',
        todoTitle: '仮',
        dueDate: DateTime.now(),
        createdDate: DateTime.now(),
        important: false,
        isCompleted: true,
      ),
      TodoModel(
        id: '3',
        todoTitle: '仮',
        dueDate: DateTime.now(),
        createdDate: DateTime.now(),
        important: false,
        isCompleted: true,
      ),
    ];
  }

  Future<void> deleteCompletedTodo(String id) async {
    final currentTodos = state.value ?? [];
    final updatedTodos =
        currentTodos.where((completedTodo) => completedTodo.id != id).toList();
    state = AsyncValue.data(updatedTodos);
  }
}
