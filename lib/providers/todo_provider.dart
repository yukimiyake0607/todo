import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/services/hive_service.dart';
import 'package:uuid/uuid.dart';

part 'todo_provider.g.dart';

@riverpod
HiveService hiveService(HiveServiceRef ref) {
  return HiveService();
}

@riverpod
class Todo extends _$Todo {
  final Uuid _uuid = const Uuid();
  @override
  FutureOr<List<TodoModel>> build() async {
    final service = ref.read(hiveServiceProvider);
    await service.init();
    return service.getAllTodo();
  }

  Future<void> addTodo(String todoTitle, String todoSubtitle) async {
    final TodoModel newTodo =
        TodoModel(id: _uuid.v4(), title: todoTitle, subTitle: todoSubtitle);
    final service = ref.read(hiveServiceProvider);
    await service.addTodoBox(newTodo);
    state = AsyncValue.data([...?state.value, newTodo]);
  }

  Future<void> toggleTodoChecked(String id) async {
    final service = ref.read(hiveServiceProvider);
    await service.toggleTodoBox(id);
    state = AsyncValue.data([
      for (final todo in state.value ?? [])
        if (id == todo.id) todo.copyWith(isChecked: !todo.isChecked) else todo
    ]);
  }

  Future<void> deleteTodo(String id) async {
    final service = ref.read(hiveServiceProvider);
    await service.deleteTodoBox(id);
    final newState = state.value?.where((todo) => todo.id != id).toList() ?? [];
    state = AsyncValue.data(newState);
  }
}
