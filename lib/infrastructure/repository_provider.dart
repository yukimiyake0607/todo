import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo/domain/repositories/todo_repository.dart';
import 'package:todo/infrastructure/todo_repository_impl.dart';

part 'repository_provider.g.dart';

@riverpod
ITodoRepository todoRepository (WidgetRef ref) {
  return FirebaseTodoRepository();
}