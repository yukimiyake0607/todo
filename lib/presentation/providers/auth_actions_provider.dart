import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/infrastructure/auth_provider.dart';
import 'package:todo/presentation/core/messages/auth_error_message.dart';
import 'package:todo/presentation/providers/todo_provider.dart';

// AuthActionsを提供するプロバイダー
final authActionsProvider = Provider<AuthActions>((ref) {
  return AuthActions(ref);
});

// ユースケースの役割
class AuthActions {
  final Ref _ref;

  AuthActions(this._ref);

  // メールとパスワードでサインイン
  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
    VoidCallback onSuccess,
    Function(String) onError,
  ) async {
    _ref.read(authActionStateProvider.notifier).state =
        const AsyncValue.loading();

    try {
      final authRepository = _ref.read(authRepositoryProvider);
      await authRepository.signInWithEmailAndPassword(email, password);
      _ref.read(todoActionStateProvider.notifier).state =
          const AsyncValue.data(null);
      onSuccess;
    } on FirebaseAuthException catch (e, _) {
      _ref.read(todoActionStateProvider.notifier).state =
          AsyncValue.error(e, _);
      onError(getErrorMessage(e));
    } on Exception catch (e, _) {
      _ref.read(todoActionStateProvider.notifier).state =
          AsyncValue.error(e, _);
      onError('エラーが発生しました');
    }
  }

  // メールとパスワードで会員登録
  Future<void> createUserWithEmailAndPassword(
    String email,
    String password,
    VoidCallback onSuccess,
    Function(String) onError,
  ) async {
    _ref.read(todoActionStateProvider.notifier).state =
        const AsyncValue.loading();

    try {
      final authRepository = _ref.read(authRepositoryProvider);
      await authRepository.createUserWithEmailAndPassword(email, password);
      _ref.read(todoActionStateProvider.notifier).state =
          const AsyncValue.data(null);
      onSuccess;
    } on FirebaseAuthException catch (e, _) {
      _ref.read(todoActionStateProvider.notifier).state =
          AsyncValue.error(e, _);
      onError(getErrorMessage(e));
    } on Exception catch (e, _) {
      _ref.read(todoActionStateProvider.notifier).state =
          AsyncValue.error(e, _);
      onError('エラーが発生しました');
    }
  }

  // Googleでサインイン
  Future<void> signInWithGoogle(
    VoidCallback onSuccess,
    Function(String) onError,
  ) async {
    _ref.read(todoActionStateProvider.notifier).state =
        const AsyncValue.loading();

    try {
      final authRepository = _ref.read(authRepositoryProvider);
      await authRepository.signInWithGoogle();
      _ref.read(todoActionStateProvider.notifier).state =
          const AsyncValue.data(null);
      onSuccess();
    } on FirebaseAuthException catch (e, _) {
      _ref.read(todoActionStateProvider.notifier).state =
          AsyncValue.error(e, _);
      onError(getErrorMessage(e));
    } on Exception catch (e, _) {
      _ref.read(todoActionStateProvider.notifier).state =
          AsyncValue.error(e, _);
      onError('エラーが発生しました');
    }
  }

  // サインアウト
  Future<void> signOut() async {
    _ref.read(todoActionStateProvider.notifier).state =
        const AsyncValue.loading();

    try {
      final authRepository = _ref.read(authRepositoryProvider);
      await authRepository.signOut();
    } on Exception catch (e, _) {
      _ref.read(todoActionStateProvider.notifier).state =
          AsyncValue.error(e, _);
    }
  }

  // パスワードリセットメールの送信
  Future<void> resetPassword(
    String email,
    VoidCallback onSuccess,
    Function(String) onError,
  ) async {
    _ref.read(todoActionStateProvider.notifier).state =
        const AsyncValue.loading();

    try {
      final authRepository = _ref.read(authRepositoryProvider);
      await authRepository.sendPasswordResetEmail(email);
      _ref.read(todoActionStateProvider.notifier).state =
          const AsyncValue.data(null);
      onSuccess;
    } on FirebaseAuthException catch (e, _) {
      _ref.read(todoActionStateProvider.notifier).state =
          AsyncValue.error(e, _);
      onError(getErrorMessage(e));
    } on Exception catch (e, _) {
      _ref.read(todoActionStateProvider.notifier).state =
          AsyncValue.error(e, _);
      onError('エラーが発生しました');
    }
  }
}
