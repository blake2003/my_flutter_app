// lib/models/register_model.dart
import 'package:flutter/material.dart';
import 'package:flutter_test1/Services/auth_service.dart';

class RegisterModel extends ChangeNotifier {
  // 控制器
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // 状态
  bool _isLoading = false;
  String? _errorMessage;

  // getters
  bool get isLoading => _isLoading;
  String? get error => _errorMessage;

  /// 执行注册，返回 true = 成功、false = 失败
  Future<bool> submit() async {
    _setLoading(true);
    _setError(null);

    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    // 验证密码是否匹配
    if (password != confirmPassword) {
      _setError('密码不匹配');
      _setLoading(false);
      return false;
    }

    try {
      // 调用注册服务
      final result = await RegisterService.register(
        email: email,
        password: password,
      );

      if (result != null) {
        // 服务层返回错误信息
        _setError(result);
        return false;
      }
      return true;
    } catch (e, st) {
      // 捕获任何非预期异常
      _setError('注册时发生非预期错误');
      debugPrint('RegisterModel.submit exception: $e\n$st');
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
    confirmPasswordController.dispose();

    super.dispose();
  }
}
