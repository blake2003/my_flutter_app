import 'package:flutter/material.dart';
import 'package:flutter_test1/pages/AuthPage/signin_page.dart';

/// SplashScreen：進入應用程式後的啟動頁
class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  SplashScreenPageState createState() => SplashScreenPageState();
}

class SplashScreenPageState extends State<SplashScreenPage> {
  bool startAnimation = false;

  @override
  void initState() {
    super.initState();

    /// 延遲 1 秒後開始播放動畫
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        startAnimation = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedOpacity(
          opacity: startAnimation ? 0.0 : 1.0,
          duration: const Duration(milliseconds: 2000),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 2000),
            width: startAnimation ? 150.0 : 250.0,
            child: Image.asset("images/netflix_logo.jpeg"),
            onEnd: () {
              /// 動畫結束後跳轉到 MyHomePage
              Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => SignInPage(),
              ));
            },
          ),
        ),
      ),
    );
  }
}
