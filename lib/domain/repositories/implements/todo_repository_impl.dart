// todo_repositoryのインターフェースをimplementして実装を作成

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/domain/entities/todo_model.dart';
import 'package:todo/domain/repositories/interfaces/todo_repository_interface.dart';

class FirebaseTodoRepository implements ITodoRepository {
  final FirebaseFirestore _firestore;
  final String _collection = 'todos';
  final String? _userId;

  FirebaseTodoRepository(
      {FirebaseFirestore? firestore, required String? userId})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _userId = userId;

  // コレクションの参照を取得（ユーザIDごとに分ける）
  CollectionReference<Map<String, dynamic>> get _todosRef {
    if (_userId == null) {
      throw Exception('ユーザーがログインしていません');
    }
    return _firestore.collection('users/$_userId/$_collection');
  }

  @override
  Stream<List<TodoModel>> getAllTodos() {
    if (_userId == null) {
      return Stream.value([]);
    }

    return _todosRef
        .orderBy('createdDate', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return TodoModel.fromFirestore(doc);
      }).toList();
    });
  }

  @override
  Stream<List<TodoModel>> getCompletedTodo() {
    if (_userId == null) {
      return Stream.value([]);
    }

    return _todosRef
        .where('isCompleted', isEqualTo: true)
        .orderBy('createdDate', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return TodoModel.fromFirestore(doc);
      }).toList();
    });
  }

  @override
  Stream<List<TodoModel>> getInCompletedTodo() {
    if (_userId == null) {
      return Stream.value([]);
    }

    return _todosRef
        .where('isCompleted', isEqualTo: false)
        .orderBy('createdDate', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return TodoModel.fromFirestore(doc);
      }).toList();
    });
  }

  @override
  Future<String> addTodo(TodoModel todoModel) async {
    if (_userId == null) {
      throw Exception('ユーザーがログインしていません');
    }

    final docRef = await _todosRef.add(TodoModel.toFirestore(todoModel));
    return docRef.id;
  }

  @override
  Future<void> updateTodo(TodoModel todoModel) async {
    if (_userId == null) {
      throw Exception('ユーザーがログインしていません');
    }

    await _todosRef.doc(todoModel.id).update(TodoModel.toFirestore(todoModel));
  }

  @override
  Future<void> deleteTodo(String id) async {
    if (_userId == null) {
      throw Exception('ユーザーがログインしていません');
    }

    await _todosRef.doc(id).delete();
  }

  @override
  Future<void> setTodoCompleted(TodoModel todoModel, bool isCompelted) async {
    if (_userId == null) {
      throw Exception('ユーザーがログインしていません');
    }

    final updatedTodo = todoModel.copyWith(isCompleted: isCompelted);
    await _todosRef
        .doc(todoModel.id)
        .update(TodoModel.toFirestore(updatedTodo));
  }
}
