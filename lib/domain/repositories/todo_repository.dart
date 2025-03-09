import 'package:todo/domain/entities/todo_model.dart';

abstract class ITodoRepository {
  // すべてのTodoを取得する
  Stream<List<TodoModel>> getAllTodos();

  // 完了したTodoを取得する
  Stream<List<TodoModel>> getCompletedTodo();

  // 未完了のTodoを取得する
  Stream<List<TodoModel>> getInCompletedTodo();

  // Todoを追加する
  Future<String> addTodo(TodoModel todoModel);

  // Todoを更新する
  Future<void> updateTodo(TodoModel todoModel);

  // Todoを削除する
  Future<void> deleteTodo(String id);

  // Todoの完了状態を確認する
  Future<void> setTodoCompleted(TodoModel todoModel, bool isCompelted);
}
