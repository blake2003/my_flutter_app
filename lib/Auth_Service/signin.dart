import 'package:firebase_auth/firebase_auth.dart';

Future<String?> signInWithEmailAndPassword(
    String email, String password) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return null; // 表示登入成功無錯誤
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return '没有找到该电子邮件对应的用户。';
    } else if (e.code == 'wrong-password') {
      return '密码错误。';
    } else {
      return '登入失敗: ${e.message}';
    }
  } catch (e) {
    return '登入失敗: $e';
  }
}
