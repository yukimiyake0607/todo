import 'package:firebase_auth/firebase_auth.dart';

String getErrorMessage(FirebaseAuthException error) {
  switch (error.code) {
    case 'user-not-found':
      return 'メールアドレスが見つかりません';
    case 'wrong-password':
      return 'パスワードが間違っています';
    case 'email-already-in-use':
      return 'このメールアドレスは既に使用されています';
    case 'weak-password':
      return 'パスワードが弱すぎます';
    case 'invalid-email':
      return 'メールアドレスの形式が正しくありません';
    case 'user-disabled':
      return 'このアカウントは無効になっています';
    case 'too-many-requests':
      return 'リクエストが多すぎます。しばらく待ってから再試行してください';
    case 'operation-not-allowed':
      return 'この操作は許可されていません';
    case 'network-request-failed':
      return 'ネットワークエラーが発生しました';
    default:
      return '認証エラーが発生しました';
  }
}
