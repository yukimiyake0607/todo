import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'todo_model.freezed.dart';
part 'todo_model.g.dart';

@freezed
class TodoModel with _$TodoModel {
  @HiveType(typeId: 0)
  const factory TodoModel({
    @HiveField(0) required String id,
    @HiveField(1) required String title,
    @HiveField(2) required String subTitle,
    @HiveField(3) @Default(false) bool isChecked,
  }) = _TodoModel;
}

extension TodoModelX on TodoModel {
  TodoModel toggleChecked() {
    return copyWith(isChecked: !isChecked);
  }
}
