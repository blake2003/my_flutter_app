// lib/models/sign_in_model.dart
import 'package:flutter/material.dart';
import 'package:flutter_test1/Data/Services/auth_service.dart';
import 'package:flutter_test1/Data/Services/credential_storage.dart';

class SignInModel extends ChangeNotifier {
  // controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // state
  bool _remember = false;
  bool _isLoading = false;
  String? _errorMessage;

  // getters
  bool get remember => _remember;
  bool get isLoading => _isLoading;
  String? get error => _errorMessage;

  SignInModel() {
    _restoreCredentials();
  }

  /// 從 SharedPreferences 載入已儲存的帳密
  Future<void> _restoreCredentials() async {
    final creds = await CredentialStorage.load();
    emailController.text = creds.email;
    passwordController.text = creds.password;
    _remember = creds.rememberMe;
    notifyListeners();
  }

  /// 切換「記住我」狀態
  void toggleRemember(bool? v) {
    _remember = v ?? false;
    notifyListeners();
  }

  /// 執行登入，返回 true = 成功、false = 失敗
  Future<bool> submit() async {
    _setLoading(true);
    _setError(null);

    final email = emailController.text.trim();
    final pwd = passwordController.text.trim();

    try {
      // ① 呼叫 SignInService，這裡它已經處理了 FirebaseAuthException
      final result = await SignInService.signIn(
        email: email,
        password: pwd,
        remember: _remember,
      );
      if (result != null) {
        // 服務層回傳錯誤訊息
        _setError(result);
        return false;
      }
      return true;
    } catch (e, st) {
      // ② 再 catch 一次：攔截任何非預期例外
      _setError('登入時發生非預期錯誤');
      debugPrint('SignInModel.submit exception: $e\n$st');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // private helpers
  void _setLoading(bool v) {
    if (_isLoading == v) return;
    _isLoading = v;
    notifyListeners();
  }

  void _setError(String? msg) {
    if (_errorMessage == msg) return;
    _errorMessage = msg;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
