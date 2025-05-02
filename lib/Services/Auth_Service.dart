import 'package:firebase_auth/firebase_auth.dart';
import '../Check/validator.dart';
import '../logger/app_logger.dart';
import '../logger/auth_log.dart';
import 'credential_storage.dart';

/// 註冊
Future<void> registerWithEmailAndPassword(String email, String password) async {
  final log = AppLogger('register');
  log.i('註冊中...');

  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    // 注册成功后的处理
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      log.i('密码强度不足。');
    } else if (e.code == 'email-already-in-use') {
      log.i('该电子邮件地址已被使用。');
    }
  } catch (e) {
    log.e('註冊失敗: $e');
    // 其他錯誤處理
  } finally {
    log.i('註冊結束');
  }
}

/// 登出
Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
}

/// 登入
class SignInService {
  static Future<String?> signIn({
    required String email,
    required String password,
    required bool remember,
  }) async {
    // 前置驗證
    if (email.isEmpty || password.isEmpty) {
      return '請輸入 Email 和密碼';
    }
    if (!Validator.isValidEmail(email)) {
      return 'Email 格式不正確';
    }
    if (!Validator.isValidPassword(password)) {
      return '密碼格式不符合要求';
    }

    // 1️⃣ 把真正的 FirebaseAuth 呼叫獨立出來
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          return '查無此帳號，請先註冊或檢查輸入';
        case 'wrong-password':
          return '密碼錯誤，請再試一次';
        case 'invalid-credential':
          return '帳號或密碼錯誤';
        default:
          return '登入失敗：${e.message ?? e.code}';
      }
    } catch (e) {
      return '登入失敗（FirebaseAuth）：$e';
    }

    // 如果上面没错，再跑后面的
    try {
      await Logger.logEvent('SignIn success', detail: email);
    } catch (_) {/* 忽略 log 失敗 */}

    try {
      await CredentialStorage.save(
        remember: remember,
        email: email,
        password: password,
      );
    } catch (_) {/* 忽略存取失敗 */}

    return null;
  }
}

class ForgotPassword {
  /// 傳送重設密碼郵件，成功回傳 null，失敗回傳錯誤字串
  static Future<String?> sendPasswordResetEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.code; // 或 e.message
    } catch (e) {
      return e.toString();
    }
  }
}
