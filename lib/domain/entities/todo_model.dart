import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_model.freezed.dart';

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
}