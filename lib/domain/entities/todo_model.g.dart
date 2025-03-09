// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoModelImpl _$$TodoModelImplFromJson(Map<String, dynamic> json) =>
    _$TodoModelImpl(
      id: json['id'] as String,
      todoTitle: json['todoTitle'] as String,
      dueDate: json['dueDate'] == null
          ? null
          : DateTime.parse(json['dueDate'] as String),
      createdDate: DateTime.parse(json['createdDate'] as String),
      important: json['important'] as bool?,
      isCompleted: json['isCompleted'] as bool,
    );

Map<String, dynamic> _$$TodoModelImplToJson(_$TodoModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'todoTitle': instance.todoTitle,
      'dueDate': instance.dueDate?.toIso8601String(),
      'createdDate': instance.createdDate.toIso8601String(),
      'important': instance.important,
      'isCompleted': instance.isCompleted,
    };
