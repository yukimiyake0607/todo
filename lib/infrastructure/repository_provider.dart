import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo/domain/repositories/implements/auth_repository_impl.dart';
import 'package:todo/domain/repositories/interfaces/auth_repository_interface.dart';
import 'package:todo/domain/repositories/interfaces/todo_repository_interface.dart';
import 'package:todo/domain/repositories/implements/todo_repository_impl.dart';
import 'package:todo/infrastructure/auth_provider.dart';

// 認証リポジトリプロバイダー
final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  return FirebaseAuthRepository();
});

// Todoリポジトリプロバイダ
final todoRepositoryProvider = Provider<ITodoRepository>((ref) {
  final userId = ref.watch(currentUserIdProvider);
  return FirebaseTodoRepository(userId: userId);
});
