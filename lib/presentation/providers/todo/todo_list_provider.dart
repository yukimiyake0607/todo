import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo/domain/entities/todo_model.dart';
import 'package:todo/infrastructure/todo/todo_repository_impl.dart';
import 'package:uuid/uuid.dart';

part 'todo_list_provider.g.dart';

@riverpod
class TodoList extends _$TodoList {
  late StreamSubscription<List<TodoModel>> _subscription;

  @override
  FutureOr<List<TodoModel>> build() {
    final repository = ref.watch(todoRepositoryProvider);

    // Firestoreから未完了のTodoを取得するStreamを監視
    _subscription = repository.getInCompletedTodo().listen(
      // データ受信時
      (todos) {
        state = AsyncValue.data(todos);
      },
      onError: (error, _) {
        state = AsyncValue.error(error, _);
      },
    );

    ref.onDispose(() {
      _subscription.cancel();
    });

    return [];
  }

  Future<void> createTodo(
    String todoTitle,
    DateTime? dueDate,
    DateTime createdDate,
    bool important,
  ) async {
    state = const AsyncValue.loading();

    try {
      // 新規TODOを作成
      final newTodo = TodoModel(
        id: const Uuid().v4(),
        todoTitle: todoTitle,
        dueDate: dueDate,
        createdDate: createdDate,
        important: important,
        isCompleted: false,
      );

      // FirestoreにTodoを追加
      final repository = ref.read(todoRepositoryProvider);
      await repository.addTodo(newTodo);

      // Streamから自動的に更新されるので、state更新は不要
    } on Exception catch (e, _) {
      state = AsyncValue.error(e, _);
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      final repository = ref.read(todoRepositoryProvider);
      await repository.deleteTodo(id);
    } on Exception catch (e, _) {
      state = AsyncValue.error(e, _);
    }
  }

  Future<void> updateTodo(
    String todoTitle,
    DateTime? dueDate,
    bool important,
    String todoId,
  ) async {
    try {
      final repository = ref.read(todoRepositoryProvider);
      final currentTodos = state.value ?? [];
      final findTodo = currentTodos.firstWhere((todo) => todo.id == todoId);

      final editTodo = findTodo.copyWith(
        todoTitle: todoTitle,
        dueDate: dueDate,
        important: important,
      );

      await repository.updateTodo(editTodo);

      // Streamから自動で更新されるため、ここでstate更新は不要
    } on Exception catch (e, _) {
      state = AsyncValue.error(e, _);
    }
  }
}
