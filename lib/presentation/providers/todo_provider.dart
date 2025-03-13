import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/domain/entities/todo_model.dart';
import 'package:todo/infrastructure/todo/todo_repository_impl.dart';
import 'package:uuid/uuid.dart';

// 未完了Todoを監視するストリームプロバイダー
final incompleteTodoProvider = StreamProvider<List<TodoModel>>((ref) {
  final todoRepository = ref.watch(todoRepositoryProvider);
  return todoRepository.getInCompletedTodo();
});

// 完了したTodoを監視するストリームプロバイダー
final completeTodoProvider = StreamProvider<List<TodoModel>>((ref) {
  final todoRepository = ref.watch(todoRepositoryProvider);
  return todoRepository.getCompletedTodo();
});

// すべてのTodoを監視するストリームプロバイダー
final allTodoProvider = StreamProvider<List<TodoModel>>((ref) {
  final todoRepository = ref.watch(todoRepositoryProvider);
  return todoRepository.getAllTodos();
});

// todoアクションの状態を管理するプロバイダー
final todoActionStateProvider = StateProvider<AsyncValue<void>>((ref) {
  return const AsyncValue.data(null);
});

// Todo操作用のプロバイダ
final todoActionsProvider = Provider<TodoActions>((ref) {
  return TodoActions(ref);
});

// Todo操作を行うクラス
class TodoActions {
  final Ref _ref;

  TodoActions(this._ref);

  // Todo追加
  Future<void> createTodo(
    String todoTitle,
    DateTime? dueDate,
    bool important,
  ) async {
    final repository = _ref.read(todoRepositoryProvider);
    _ref.read(todoActionStateProvider.notifier).state =
        const AsyncValue.loading();

    try {
      final newTodo = TodoModel(
        id: const Uuid().v4(),
        todoTitle: todoTitle,
        dueDate: dueDate,
        createdDate: DateTime.now(),
        important: important,
        isCompleted: false,
      );

      // FirestoreにTodoを追加
      await repository.addTodo(newTodo);

      _ref.read(todoActionStateProvider.notifier).state =
          const AsyncValue.data(null);
    } on Exception catch (e, _) {
      _ref.read(todoActionStateProvider.notifier).state =
          AsyncValue.error(e, _);
      rethrow;
    }
  }

  // Todo削除
  Future<void> deleteTodo(String id) async {
    final repository = _ref.read(todoRepositoryProvider);
    _ref.read(todoActionStateProvider.notifier).state =
        const AsyncValue.loading();

    try {
      await repository.deleteTodo(id);
      _ref.read(todoActionStateProvider.notifier).state =
          const AsyncValue.data(null);
    } on Exception catch (e, _) {
      _ref.read(todoActionStateProvider.notifier).state =
          AsyncValue.error(e, _);
      rethrow;
    }
  }

  // Todo更新
  Future<void> updateTodo(
    String todoTitle,
    DateTime? dueDate,
    bool important,
    String todoId,
  ) async {
    final repository = _ref.read(todoRepositoryProvider);
    _ref.read(todoActionStateProvider.notifier).state =
        const AsyncValue.loading();

    try {
      // 現在のTodo取得
      final allTodosAsync = await _ref.read(allTodoProvider.future);
      final todoToUpdate =
          allTodosAsync.firstWhere((todo) => todo.id == todoId);

      // 更新されたTodoを作成
      final updateTodo = todoToUpdate.copyWith(
        todoTitle: todoTitle,
        dueDate: dueDate,
        important: important,
      );

      await repository.updateTodo(updateTodo);

      _ref.read(todoActionStateProvider.notifier).state =
          const AsyncValue.data(null);
    } on Exception catch (e, _) {
      _ref.read(todoActionStateProvider.notifier).state =
          AsyncValue.error(e, _);
      rethrow;
    }
  }

  Future<void> toggleTodo(TodoModel todo) async {
    final repository = _ref.read(todoRepositoryProvider);
    _ref.read(todoActionStateProvider.notifier).state =
        const AsyncValue.loading();

    try {
      await repository.setTodoCompleted(todo, !todo.isCompleted);

      _ref.read(todoActionStateProvider.notifier).state =
          const AsyncValue.data(null);
    } on Exception catch (e, _) {
      _ref.read(todoActionStateProvider.notifier).state =
          AsyncValue.error(e, _);
      rethrow;
    }
  }
}
