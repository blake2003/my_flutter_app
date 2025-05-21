// lib/pages/AuthPage/sign_in_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_test1/UI/Pages/AuthPage/Body/sign_body.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);
  static const String routeName = '/signin';

  @override
  Widget build(BuildContext context) {
    // 如果你想在進入此頁時強制 restore 一次，也可以：
    // context.read<SignInModel>().restore();

    return const SignInBody();
  }
}
