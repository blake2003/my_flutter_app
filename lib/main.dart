import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_test1/providers/gfalert_provider.dart';
import 'package:flutter_test1/pages/splash_screen_page.dart';
// 你自訂的檔案路徑請按照實際專案調整
import 'firebase_options.dart';
import 'logger/logger.dart';
import 'logger/error_handler.dart';

/// 進入點：負責執行 Flutter App
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    // 在這裡可以記錄或上傳錯誤訊息，例如使用 Crashlytics
    print('Firebase 初始化失敗：$e');
    // FirebaseCrashlytics.instance.recordError(e, null, fatal: true);
  }
  // 全域日誌與錯誤處理設定
  setupGlobalLogging();
  setupGlobalErrorHandlers();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<GfAlertProvider>(
          create: (_) => GfAlertProvider(),
        ),
        // ... 其他 Provider
      ],
      child: const MyApp(),
    ),
  );
}

/// 整個 App 的根組件
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '空氣品質監測地區',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreenPage(),
    );
  }
}


/*所有GFwidgets皆參考以下資訊
    作者：Haoyu
    链接：https://juejin.cn/post/7081298839323279373
    来源：稀土掘金
    著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。*/