import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthRepository {
  // ユーザーの認証状態を監視
  Stream<User?> get authStateChanges;

  // 現在のユーザーID（nullの場合は未認証）
  String? get currentUserId;

  // 現在のユーザーがログインしているか？
  bool get isSignedIn;

  // メールアドレスとパスワードでサインイン
  Future<UserCredential> signInWithEmailAndPassword(
      String email, String password);

  // メールアドレスとパスワードで新規登録
  Future<UserCredential> createUserWithEmailAndPassword(
      String email, String password);

  // サインアウト
  Future<void> signOut();

  // パスワードリセットメールの送信
  Future<void> sendPasswordResetEmail(String email);
}
