import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/models/todo_model.dart';

class HiveService {
  final String _boxName = 'todoBox';

  Future<void> init() async {
    await Hive.openBox<TodoModel>(_boxName);
  }

  Future<List<TodoModel>> getAllTodo() async {
    final box = Hive.box<TodoModel>(_boxName);
    return box.values.toList();
  }

  Future<void> addTodoBox(TodoModel todo) async {
    final box = Hive.box<TodoModel>(_boxName);
    await box.put(todo.id, todo);
  }

  Future<void> toggleTodoBox(String id) async {
    final box = Hive.box<TodoModel>(_boxName);
    final todo = box.get(id);
    if (todo != null) {
      final updatedTodo = todo.toggleChecked();
      await box.put(id, updatedTodo);
    }
  }

  Future<void> deleteTodoBox(String id) async {
    final box = Hive.box<TodoModel>(_boxName);
    await box.delete(id);
  }
}
