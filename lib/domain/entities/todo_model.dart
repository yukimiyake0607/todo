import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_model.freezed.dart';
part 'todo_model.g.dart';

@freezed
class TodoModel with _$TodoModel {
  const factory TodoModel({
    required String id,
    required String todoTitle,
    required DateTime? dueDate,
    required DateTime createdDate,
    required bool? important,
    required bool isCompleted,
  }) = _TodoModel;

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);

  // Firestoreのデータからモデルを作成するファクトリメソッド
  factory TodoModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return TodoModel(
      id: doc.id,
      todoTitle: data['todoTitle'].toString(),
      dueDate: data['dueDate'] != null
          ? (data['dueDate'] as Timestamp).toDate()
          : null,
      createdDate: (data['createdDate'] as Timestamp).toDate(),
      important: data['important'] as bool?,
      isCompleted: data['isCompleted'] as bool,
    );
  }

  // モデルをFirestoreに保存するためのマップに変換するメソッド
  static Map<String, dynamic> toFirestore(TodoModel todoModel) {
    return {
      'todoTitle': todoModel.todoTitle,
      'dueDate': todoModel.dueDate != null
          ? Timestamp.fromDate(todoModel.dueDate!)
          : null,
      'createdDate': Timestamp.fromDate(todoModel.createdDate),
      'important': todoModel.important,
      'isCompleted': todoModel.isCompleted,
    };
  }
}
