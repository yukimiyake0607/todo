import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/domain/repositories/interfaces/auth_repository_interface.dart';
import 'package:todo/domain/repositories/implements/auth_repository_impl.dart';

// 認証リポジトリプロバイダー
final authRepositoryProvider = Provider<IAuthRepository>((ref) {
  return FirebaseAuthRepository();
});

// 現在の認証状態を確認するストリームプロバイダー
final authStateProvider = StreamProvider<User?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges;
});

// ユーザーがサインインしているかどうかを確認するプロバイダー
final isSignedInProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.maybeWhen(
    data: (user) => user != null,
    orElse: () => false,
  );
});

// 現在のユーザーIDプロバイダー
final currentUserIdProvider = Provider<String?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.currentUserId;
});

// 認証アクションの状態を管理するプロバイダー
final authActionStateProvider = StateProvider<AsyncValue<void>>((ref) {
  return const AsyncValue.data(null);
});
