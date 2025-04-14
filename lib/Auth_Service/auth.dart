import 'package:firebase_auth/firebase_auth.dart';

/// 註冊
Future<String?> registerWithEmailAndPassword(
    String email, String password) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return null; // null 表示成功
  } on FirebaseAuthException catch (e) {
    return e.code; // 回傳錯誤代碼給呼叫端
  } catch (e) {
    return e.toString();
  }
}

/// 登入
Future<String?> signInWithEmailAndPassword(
    String email, String password) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return null; // null 表示成功
  } on FirebaseAuthException catch (e) {
    return e.code;
  } catch (e) {
    return e.toString();
  }
}

/// 登出
Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
}
