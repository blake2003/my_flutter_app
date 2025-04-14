import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test1/Auth_Service/register.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _register() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnackBar("請輸入 Email 和密碼");
      return;
    }

    setState(() => _isLoading = true);

    try {
      await registerWithEmailAndPassword(email, password);
      _showSnackBar("註冊成功");
      Navigator.pop(context); // 成功後返回上一頁（登入頁）
    } on FirebaseAuthException catch (e) {
      String msg;
      if (e.code == 'weak-password') {
        msg = '密碼強度不足，請增加密碼長度或複雜度';
      } else if (e.code == 'email-already-in-use') {
        msg = '這個 Email 已被註冊過，請改用其他帳號';
      } else {
        msg = '註冊失敗: ${e.message}';
      }
      _showSnackBar(msg);
    } catch (e) {
      _showSnackBar("註冊失敗: $e");
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
      appBar: AppBar(title: Text("註冊帳號")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: "密碼"),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _register,
                    child: Text("註冊"),
                  ),
          ],
        ),
      ),
    );
  }
}
