import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../Services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  static const String routeName = '/register';

  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _register() async {
    setState(() => _isLoading = true);

    // 1. 同步阶段先抓住 navigator 和 messenger
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar("請輸入 Email 和密碼");
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 2. 真正发起异步注册
      await registerWithEmailAndPassword(email, password);

      // 3. 用之前抓好的 messenger 和 navigator
      messenger.showSnackBar(
        const SnackBar(content: Text('註冊成功')),
      );
      navigator.pop();
    } on FirebaseAuthException catch (e) {
      String msg;
      if (e.code == 'weak-password') {
        msg = '密碼強度不足，請增加密碼長度或複雜度';
      } else if (e.code == 'email-already-in-use') {
        msg = '這個 Email 已被註冊過，請改用其他帳號';
      } else {
        msg = '註冊失敗: ${e.message}';
      }
      messenger.showSnackBar(SnackBar(content: Text(msg)));
    } catch (e) {
      messenger.showSnackBar(SnackBar(content: Text('註冊失敗: $e')));
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
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
      appBar: AppBar(title: const Text("註冊帳號")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "密碼"),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _register,
                    child: const Text("註冊"),
                  ),
          ],
        ),
      ),
    );
  }
}
