import 'package:shared_preferences/shared_preferences.dart';

/// 資料模型 ─ 也可以用 record (Dart 3) 或 freezed
class SavedCredential {
  final String email;
  final String password;
  final bool rememberMe; // 與 model 相同
  const SavedCredential(
      {required this.email, required this.password, required this.rememberMe});
}

class CredentialStorage {
  static const _kEmailKey = 'saved_email';
  static const _kPwdKey = 'saved_password';
  static const _kRemember = 'remember_me';

  /// 載入；若未勾 [remember_me] 則回傳空字串
  static Future<SavedCredential> load() async {
    final prefs = await SharedPreferences.getInstance();
    final remember = prefs.getBool(_kRemember) ?? false;
    return SavedCredential(
      email: remember ? (prefs.getString(_kEmailKey) ?? '') : '',
      password: remember ? (prefs.getString(_kPwdKey) ?? '') : '',
      rememberMe: remember,
    );
  }

  /// 儲存或清除
  static Future<void> save({
    required bool remember,
    required String email,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    if (remember) {
      prefs
        ..setString(_kEmailKey, email)
        ..setString(_kPwdKey, password)
        ..setBool(_kRemember, true);
    } else {
      prefs
        ..remove(_kEmailKey)
        ..remove(_kPwdKey)
        ..setBool(_kRemember, false);
    }
  }
}
