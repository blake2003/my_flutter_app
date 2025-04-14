import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter_test1/pages/introduce_page.dart';
import 'package:flutter_test1/pages/my_home_page.dart';

import '../pages/AuthPage/signin_page.dart';
import '../pages/guidePage/TPIWalkThroughScreen.dart';

/// GfDrawer：自定義 Drawer，提供多項選單功能
class GfDrawer extends StatelessWidget {
  const GfDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GFDrawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeaderWidget(),
          DrawerListTile(
            title: '首頁',
            onTap: () => _navigateTo(context, const MyHomePage()),
          ),
          DrawerListTile(
            title: '介紹',
            onTap: () => _navigateTo(context, const IntroducePage()),
          ),
          DrawerListTile(
            title: '回導覽頁',
            onTap: () => _navigateTo(context, const TPIWalkThroughScreen()),
          ),
          // 新增「登出」按鈕
          DrawerListTile(
            title: '登出',
            onTap: () => _handleLogout(context),
          ),
        ],
      ),
    );
  }

  /// 導航至指定頁面
  void _navigateTo(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  /// 登出處理：呼叫 FirebaseAuth 的 signOut 並跳轉到登入頁
  Future<void> _handleLogout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    // 登出後直接用 pushReplacement 清除當前路由並跳轉到登入頁，請根據實際情況調整 SignInPage 的路徑
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => SignInPage()),
    );
  }
}

/// DrawerHeaderWidget：Drawer 的頭部
class DrawerHeaderWidget extends StatelessWidget {
  const DrawerHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const GFDrawerHeader(
      currentAccountPicture: GFAvatar(
        backgroundImage: AssetImage('images/cat.jpeg'),
      ),
      decoration: BoxDecoration(
        color: GFColors.PRIMARY,
      ),
      otherAccountsPictures: [
        GFAvatar(
          backgroundImage: AssetImage('images/cat.jpeg'),
        ),
      ],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('小黑', style: TextStyle(color: Colors.white)),
          Text('Flutter新手小白', style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

/// DrawerListTile：客製化的 ListTile 用於 Drawer
class DrawerListTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const DrawerListTile({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      onTap: onTap,
    );
  }
}
