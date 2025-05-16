import 'package:flutter/foundation.dart'; // kDebugMode
import 'package:logging/logging.dart';
import 'package:ansicolor/ansicolor.dart';

class AppLogger {
  factory AppLogger(String name) =>
      _cache.putIfAbsent(name, () => AppLogger._(name));
  AppLogger._(this._name);
  final String _name;
  static final _cache = <String, AppLogger>{};

  // 快捷呼叫
  void d(Object msg) => Logger(_name).fine(msg);
  void i(Object msg) => Logger(_name).info(msg);
  void w(Object msg) => Logger(_name).warning(msg);
  void e(Object msg, [Object? err, StackTrace? st]) =>
      Logger(_name).severe(msg, err, st);

  /// 在 main() 中最早呼叫一次
  static void init() {
    Logger.root.level = kDebugMode ? Level.ALL : Level.WARNING;
    hierarchicalLoggingEnabled = true;

    // ---------- ❶ 建立各層級對應的彩色筆 ----------
    final levelPens = {
      Level.FINE: AnsiPen()..blue(), // debug
      Level.INFO: AnsiPen()..white(bold: true), // info
      Level.WARNING: AnsiPen()..yellow(bold: true), // warning
      Level.SEVERE: AnsiPen()..red(bold: true), // error
      Level.SHOUT: AnsiPen()..red(bg: true, bold: true), // fatal
    };

    // ---------- ❷ 監聽日誌 ----------
    Logger.root.onRecord.listen((rec) async {
      // Release 直接關閉顏色
      ansiColorDisabled = !kDebugMode;

      final pen = levelPens[rec.level] ?? AnsiPen();
      final timestamp =
          rec.time.toIso8601String().substring(11, 19); // HH:mm:ss
      final line = pen('[${rec.level.name}] $timestamp '
          '${rec.loggerName}: ${rec.message}');
      if (kDebugMode) debugPrint(line);

      // SEVERE 以上可上傳遠端
      if (rec.level >= Level.SEVERE) await _upload(rec);
    });
  }

  static Future<void> _upload(LogRecord r) async {
    // TODO: Crashlytics / Sentry / 自建 API
  }
}

// log顏色不會改變