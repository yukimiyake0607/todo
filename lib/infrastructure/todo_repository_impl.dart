// todo_repositoryのインターフェースをimplementして実装を作成

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/domain/entities/todo_model.dart';
import 'package:todo/domain/repositories/todo_repository_interface.dart';

class FirebaseTodoRepository implements ITodoRepository {
  final FirebaseFirestore _firestore;
  final String _collection = 'todos';

  FirebaseTodoRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  // todosコレクションへの参照を取得
  CollectionReference<Map<String, dynamic>> get _todosRef =>
      _firestore.collection(_collection);

  // todosコレクションにアクセス、createdDateフィールドで降順（新しい順）に並び替え
  // リアルタイム更新のストリームを取得
  // 取得したデータを加工（map）
  @override
  Stream<List<TodoModel>> getAllTodos() {
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
    final docRef = await _todosRef.add(TodoModel.toFirestore(todoModel));
    return docRef.id;
  }

  @override
  Future<void> updateTodo(TodoModel todoModel) async {
    await _todosRef.doc(todoModel.id).update(TodoModel.toFirestore(todoModel));
  }

  @override
  Future<void> deleteTodo(String id) async {
    await _todosRef.doc(id).delete();
  }

  @override
  Future<void> setTodoCompleted(TodoModel todoModel, bool isCompelted) async {
    final updatedTodo = todoModel.copyWith(isCompleted: isCompelted);
    await _todosRef
        .doc(todoModel.id)
        .update(TodoModel.toFirestore(updatedTodo));
  }
}
