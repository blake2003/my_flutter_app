// logger.dart
import 'package:logging/logging.dart';

/// 全域日誌系統設定：初始化 Logger 並監聽所有 Log 訊息
void setupGlobalLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    print('[${record.level.name}] ${record.time}: ${record.message}');
    if (record.level == Level.SEVERE) {
      // 可在這裡將錯誤發送到遠端錯誤分析平台
    }
  });
}
