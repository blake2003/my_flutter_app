// lib/routes.dart
import 'package:flutter/material.dart';
import 'package:flutter_test1/Pages/AuthPage/Screens/forgot_password_screen.dart';
import 'package:flutter_test1/Pages/AuthPage/Screens/register_screen.dart';
import 'package:flutter_test1/Pages/AuthPage/Screens/signin_screen.dart';
import 'package:flutter_test1/Pages/GuidePage/tpi_walkthrough_screen.dart';
import 'package:flutter_test1/Pages/introduce_page.dart';
import 'package:flutter_test1/Pages/my_home_page.dart';
import 'package:flutter_test1/Pages/splash_screen_page.dart';

// 假設 HomePage1…HomePage30 各自存在對應檔案

// … 依序 import 到 home_page30.dart

/// 所有路由名稱
abstract class AppRoutes {
  static const splash = '/';
  static const signIn = '/signin';
  static const register = '/register';
  static const forgotPassword = '/forgot_password';
  static const guide = '/guidepage';
  static const home = '/home';
  static const introduce = '/introduce';
  // … 一直到 homePage30
}

/// Route 表
final Map<String, WidgetBuilder> appRouteTable = {
  AppRoutes.splash: (_) => const SplashScreenPage(),
  AppRoutes.signIn: (_) => const SignInScreen(),
  AppRoutes.register: (_) => const RegisterPage(),
  AppRoutes.forgotPassword: (_) => const ForgotPasswordScreen(),
  AppRoutes.guide: (_) => const TPIWalkThroughScreen(),
  AppRoutes.home: (_) => const MyHomePage(),
  AppRoutes.introduce: (_) => const IntroducePage(),

  // … 其他 homePageN
};
