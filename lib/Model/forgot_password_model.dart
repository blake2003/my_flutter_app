// lib/models/forgot_password_model.dart
import 'package:flutter/material.dart';
import 'package:flutter_test1/Services/auth_service.dart';

class ForgotPasswordModel extends ChangeNotifier {
  // 控制器，只需要 email
  final TextEditingController emailController = TextEditingController();

  // 載入中與錯誤 / 訊息狀態
  bool _isLoading = false;
  String? _errorMessage;
  String? _infoMessage;

  // getters
  bool get isLoading => _isLoading;
  String? get error => _errorMessage;
  String? get info => _infoMessage;

  /// 送出重設密碼請求
  /// 回傳 true 代表成功、false 代表失敗
  Future<bool> submit() async {
    _setLoading(true);
    _setError(null);
    _setInfo(null);

    final email = emailController.text.trim();

    try {
      // 需要在 AuthService 中實作 sendPasswordResetEmail
      final result = await ForgotPassword.sendPasswordResetEmail(email);
      if (result != null) {
        // 服務層回傳錯誤訊息（如驗證失敗、網路錯誤等）
        _setError(result);
        return false;
      }

      // 無錯誤：告知使用者信件已發送
      _setInfo('已向 $email 發送密碼重設連結');
      return true;
    } catch (e, st) {
      // 捕捉任何預期外錯誤
      _setError('發送重設郵件時發生錯誤');
      debugPrint('ForgotPasswordModel.submit exception: $e\n$st');
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

  void _setInfo(String? msg) {
    if (_infoMessage == msg) return;
    _infoMessage = msg;
    notifyListeners();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
