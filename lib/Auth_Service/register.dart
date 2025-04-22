import 'package:firebase_auth/firebase_auth.dart';
import 'package:logging/logging.dart';

Future<void> registerWithEmailAndPassword(String email, String password) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    // 注册成功后的处理
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      Logger('密码强度不足。');
    } else if (e.code == 'email-already-in-use') {
      Logger('该电子邮件地址已被使用。');
    }
  } catch (e) {
    Logger('register').severe('註冊失敗', e);
  }
}
