import 'package:firebase_auth/firebase_auth.dart';

Future<void> registerWithEmailAndPassword(String email, String password) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    // 注册成功后的处理
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('密码强度不足。');
    } else if (e.code == 'email-already-in-use') {
      print('该电子邮件地址已被使用。');
    }
  } catch (e) {
    print(e);
  }
}
