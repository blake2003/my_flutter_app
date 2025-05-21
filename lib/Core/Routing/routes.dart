// lib/routes.dart
import 'package:flutter/material.dart';
import 'package:flutter_test1/UI/Pages/AuthPage/Screens/forgot_password_screen.dart';
import 'package:flutter_test1/UI/Pages/AuthPage/Screens/register_screen.dart';
import 'package:flutter_test1/UI/Pages/AuthPage/Screens/signin_screen.dart';
import 'package:flutter_test1/UI/Pages/GuidePage/tpi_walkthrough_screen.dart';
import 'package:flutter_test1/UI/Pages/GuidePage2/guide_screen.dart';
import 'package:flutter_test1/UI/Pages/introduce_page.dart';
import 'package:flutter_test1/UI/Pages/my_home_page.dart';
import 'package:flutter_test1/UI/Pages/splash_screen_page.dart';
import 'package:flutter_test1/export/data_export.dart';

// 假設 HomePage1…HomePage30 各自存在對應檔案

// … 依序 import 到 home_page30.dart

/// 所有路由名稱
abstract class AppRoutes {
  // 基础路由
  static const splash = '/';
  static const signIn = '/signin';
  static const register = '/register';
  static const forgotPassword = '/forgot_password';
  static const guide = '/guidepage';
  static const home = '/home';
  static const introduce = '/introduce';
  static const guide2 = '/onboarding';

  // 站点路由 - 按照 HomePage 类名排序
  static const homePage1 = '/makong'; // HomePage1 - 馬公
  static const homePage2 = '/kinmen'; // HomePage2 - 金門
  static const homePage3 = '/mazu'; // HomePage3 - 馬祖
  static const homePage4 = '/yilan'; // HomePage4 - 宜蘭
  static const homePage5 = '/yangming'; // HomePage5 - 陽明
  static const homePage6 = '/hualien'; // HomePage6 - 花蓮
  static const homePage7 = '/taitung'; // HomePage7 - 台東
  static const homePage8 = '/hengchun'; // HomePage8 - 恆春
  static const homePage9 = '/pingtung'; // HomePage9 - 屏東
  static const homePage10 = '/qianjin'; // HomePage10 - 前金
  static const homePage11 = '/meinong'; // HomePage11 - 美濃
  static const homePage12 = '/tainan'; // HomePage12 - 台南
  static const homePage13 = '/xinying'; // HomePage13 - 新營
  static const homePage14 = '/chiayi'; // HomePage14 - 嘉義
  static const homePage15 = '/puzi'; // HomePage15 - 朴子
  static const homePage16 = '/douliu'; // HomePage16 - 斗六
  static const homePage17 = '/nantou'; // HomePage17 - 南投
  static const homePage18 = '/changhua'; // HomePage18 - 彰化
  static const homePage19 = '/zhongming'; // HomePage19 - 忠明
  static const homePage20 = '/fengyuan'; // HomePage20 - 豐原
  static const homePage21 = '/sanyi'; // HomePage21 - 三重
  static const homePage22 = '/miaoli'; // HomePage22 - 苗栗
  static const homePage23 = '/hsinchu'; // HomePage23 - 新竹
  static const homePage24 = '/zhudong'; // HomePage24 - 竹東
  static const homePage25 = '/pingzhen'; // HomePage25 - 平鎮
  static const homePage26 = '/taoyuan'; // HomePage26 - 桃園
  static const homePage27 = '/wanhua'; // HomePage27 - 萬華
  static const homePage28 = '/shilin'; // HomePage28 - 士林
  static const homePage29 = '/banqiao'; // HomePage29 - 板橋
  static const homePage30 = '/xizhi'; // HomePage30 - 汐止
  static const homePage31 = '/keelung'; // HomePage31 - 基隆
}

/// Route 表
final Map<String, WidgetBuilder> appRouteTable = {
  AppRoutes.splash: (_) => const SplashScreenPage(),
  AppRoutes.signIn: (_) => const SignInScreen(),
  AppRoutes.register: (_) => const RegisterScreen(),
  AppRoutes.forgotPassword: (_) => const ForgotPasswordScreen(),
  AppRoutes.guide: (_) => const TPIWalkThroughScreen(),
  AppRoutes.guide2: (_) => const GuideScreen(),
  AppRoutes.home: (_) => const MyHomePage(),
  AppRoutes.introduce: (_) => const IntroducePage(),

  AppRoutes.homePage1: (_) => const HomePage1(),
  AppRoutes.homePage2: (_) => const HomePage2(),
  AppRoutes.homePage3: (_) => const HomePage3(),
  AppRoutes.homePage4: (_) => const HomePage4(),
  AppRoutes.homePage5: (_) => const HomePage5(),
  AppRoutes.homePage6: (_) => const HomePage6(),
  AppRoutes.homePage7: (_) => const HomePage7(),
  AppRoutes.homePage8: (_) => const HomePage8(),
  AppRoutes.homePage9: (_) => const HomePage9(),
  AppRoutes.homePage10: (_) => const HomePage10(),
  AppRoutes.homePage11: (_) => const HomePage11(),
  AppRoutes.homePage12: (_) => const HomePage12(),
  AppRoutes.homePage13: (_) => const HomePage13(),
  AppRoutes.homePage14: (_) => const HomePage14(),
  AppRoutes.homePage15: (_) => const HomePage15(),
  AppRoutes.homePage16: (_) => const HomePage16(),
  AppRoutes.homePage17: (_) => const HomePage17(),
  AppRoutes.homePage18: (_) => const HomePage18(),
  AppRoutes.homePage19: (_) => const HomePage19(),
  AppRoutes.homePage20: (_) => const HomePage20(),
  AppRoutes.homePage21: (_) => const HomePage21(),
  AppRoutes.homePage22: (_) => const HomePage22(),
  AppRoutes.homePage23: (_) => const HomePage23(),
  AppRoutes.homePage24: (_) => const HomePage24(),
  AppRoutes.homePage25: (_) => const HomePage25(),
  AppRoutes.homePage26: (_) => const HomePage26(),
  AppRoutes.homePage27: (_) => const HomePage27(),
  AppRoutes.homePage28: (_) => const HomePage28(),
  AppRoutes.homePage29: (_) => const HomePage29(),
  AppRoutes.homePage30: (_) => const HomePage30(),
  AppRoutes.homePage31: (_) => const HomePage31(),

  // … 其他 homePageN
};
