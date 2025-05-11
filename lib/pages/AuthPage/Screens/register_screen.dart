// lib/Pages/AuthPage/Screens/register.dart

import 'package:flutter/material.dart';
import 'package:flutter_test1/Pages/AuthPage/Body/register_body.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const String routeName = '/register';

  @override
  Widget build(BuildContext context) {
    return const RegisterBody();
  }
}
