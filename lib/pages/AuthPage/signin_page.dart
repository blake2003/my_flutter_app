// File: SignInPage.dart
import 'package:flutter/material.dart';
import 'package:flutter_test1/pages/guidePage/TPIWalkThroughScreen.dart';
import '../../Auth_Service/signin.dart';
import '../../Check/validator.dart';
import '../../logger/auth_log.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'register_page.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  /// 從 SharedPreferences 載入已儲存的帳密資訊
  Future<void> _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('saved_email') ?? '';
    final savedPassword = prefs.getString('saved_password') ?? '';
    final remember = prefs.getBool('remember_me') ?? false;
    if (remember) {
      setState(() {
        _emailController.text = savedEmail;
        _passwordController.text = savedPassword;
        _rememberMe = true;
      });
    }
  }

  Future<void> _signIn() async {
    final String email = _emailController.text.trim();
    final String password = _passwordController.text.trim();

    // 基本輸入檢查
    if (email.isEmpty || password.isEmpty) {
      _showSnackBar("請輸入 Email 和密碼");
      return;
    }
    if (!Validator.isValidEmail(email)) {
      _showSnackBar("Email 格式不正確");
      return;
    }
    if (!Validator.isValidPassword(password)) {
      _showSnackBar("密碼格式不符合要求");
      return;
    }

    setState(() => _isLoading = true);

    // 紀錄登入按鈕被按下的事件
    await Logger.logEvent("SignIn button pressed", detail: "Email: $email");

    // 呼叫登入 API，該方法會回傳錯誤訊息(若登入失敗)，否則回傳 null
    String? error = await signInWithEmailAndPassword(email, password);
    if (error != null) {
      _showSnackBar(error);
      await Logger.logEvent("SignIn failed", detail: error);
    } else {
      _showSnackBar("登入成功");
      await Logger.logEvent("SignIn success", detail: "Email: $email");

      // 根據是否勾選記住我，儲存或清除帳密資訊
      final prefs = await SharedPreferences.getInstance();
      if (_rememberMe) {
        await prefs.setString('saved_email', email);
        await prefs.setString('saved_password', password);
        await prefs.setBool('remember_me', true);
      } else {
        await prefs.remove('saved_email');
        await prefs.remove('saved_password');
        await prefs.setBool('remember_me', false);
      }

      // 登入成功後，跳轉到首頁 (此範例跳轉至 TPIWalkThroughScreen)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const TPIWalkThroughScreen()),
      );
    }

    setState(() => _isLoading = false);
  }

  void _goToRegisterPage() async {
    await Logger.logEvent("Navigate to RegisterPage");
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );
  }

  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("登入")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "密碼"),
            ),
            Row(
              children: [
                Checkbox(
                  value: _rememberMe,
                  onChanged: (value) {
                    setState(() {
                      _rememberMe = value ?? false;
                    });
                  },
                ),
                const Text("記住我"),
              ],
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _signIn,
                    child: const Text("登入"),
                  ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: _goToRegisterPage,
              child: const Text("還沒有帳號？前往註冊"),
            ),
          ],
        ),
      ),
    );
  }
}
