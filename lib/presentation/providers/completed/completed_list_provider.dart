import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo/domain/entities/todo_model.dart';

part 'completed_list_provider.g.dart';

@riverpod
class CompletedList extends _$CompletedList {
  @override
  FutureOr<List<TodoModel>> build() {
    return [];
  }

  Future<void> createCompletedTodo(TodoModel todoModel) async {
    final newCompletedTodo = TodoModel(
      id: todoModel.id,
      todoTitle: todoModel.todoTitle,
      dueDate: todoModel.dueDate,
      createdDate: todoModel.createdDate,
      important: todoModel.important,
      isCompleted: true,
    );

    final currentState = state.value ?? [];
    final updateState = [...currentState, newCompletedTodo];

    state = AsyncValue.data(updateState);
  }

  Future<void> deleteCompletedTodo(String id) async {
    final currentTodos = state.value ?? [];
    final updatedTodos =
        currentTodos.where((completedTodo) => completedTodo.id != id).toList();
    state = AsyncValue.data(updatedTodos);
  }
}
