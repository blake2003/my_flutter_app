import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test1/Components/Widgets/gfalert_provider.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';

// 你自訂的檔案路徑請按照實際專案調整
import 'Components/Widgets/back_to_top_notifier.dart';
import 'Model/forgot_password_model.dart';
import 'Model/register_model.dart';
import 'Model/sign_in_model.dart';
import 'Routes/routes.dart';
import 'Services/navigation_service.dart';
import 'firebase_options.dart';
import 'logger/async_logger.dart';
import 'logger/error_handler.dart';

/// 進入點：負責執行 Flutter App
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 初始化 Firebase
  // 這裡的 try-catch 是為了捕捉 Firebase 初始化過程中的任何錯誤
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    // 使用 Logger 記錄嚴重錯誤訊息，避免在 production code 中直接使用 print
    Logger('FirebaseInit').severe('Firebase 初始化失敗', e);
    // FirebaseCrashlytics.instance.recordError(e, null, fatal: true);
  }

  // 全域日誌與錯誤處理設定
  setupGlobalLogging();
  setupGlobalErrorHandlers();

  // MultiProvider 注入所有 ChangeNotifier
  runApp(
    MultiProvider(
      providers: [
        // 這裡的 ChangeNotifierProvider 是用來提供狀態管理的
        // 這些 Provider 可以在整個應用程式中被使用
        ChangeNotifierProvider(create: (_) => BackToTopNotifier()),
        ChangeNotifierProvider(create: (_) => GfAlertProvider()),
        ChangeNotifierProvider(
          create: (_) {
            final model = SignInModel();
            // model._restoreCredentials() 已在建構子裡呼叫
            return model;
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            final model = RegisterModel();

            return model;
          },
        ),
        ChangeNotifierProvider(
          create: (_) {
            final model = ForgotPasswordModel();

            return model;
          },
        ),
        Provider<NavigationService>(
          create: (_) => NavigationService(),
          // listen: false is default for Provider<T>
        ),
        // ... 如有其他 Provider 再繼續加
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
    // 1️⃣ 從 Provider 拿到同一個 NavigationService
    final navService = Provider.of<NavigationService>(context, listen: false);

    return MaterialApp(
      title: '空氣品質監測地區',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      // 首頁改成依照是否已登入決定可用 SignInModel

      // 2️⃣ 把 navigatorKey 傳進去，讓全 app 都用這把 Key 來導航
      navigatorKey: navService.navigatorKey,
      // 3️⃣ 使用 NavigatorService 的路由表
      initialRoute: AppRoutes.splash,
      routes: appRouteTable,
    );
  }
}


/*所有GFwidgets皆參考以下資訊
    作者：Haoyu
    链接：https://juejin.cn/post/7081298839323279373
    来源：稀土掘金
    著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。*/