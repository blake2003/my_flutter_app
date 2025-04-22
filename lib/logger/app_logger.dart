// lib/logger/app_logger.dart
import 'dart:async';
import 'package:ansicolor/ansicolor.dart';
import 'package:flutter/foundation.dart'; // kDebugMode
import 'package:logging/logging.dart';

/// 1) 呼叫 AppLogger('ClassName').i('message');
class AppLogger {
  factory AppLogger(String name) =>
      _cache.putIfAbsent(name, () => AppLogger._(name));
  AppLogger._(this._name);
  final String _name;
  static final Map<String, AppLogger> _cache = {};

  // 包一層，避免每次都須 import logging
  void i(Object message) => Logger(_name).info(message);
  void d(Object message) => Logger(_name).fine(message);
  void w(Object message) => Logger(_name).warning(message);
  void e(Object message, [Object? error, StackTrace? st]) =>
      Logger(_name).severe(message, error, st);

  /// 2) 在 main() 最早處呼叫一次
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
      if (rec.level >= Level.SEVERE) await _uploadToRemote(rec);
    });
  }

  /// 3) 抽象化遠端上傳，方便替換
  static Future<void> _uploadToRemote(LogRecord rec) async {
    // TODO: 整合 Crashlytics / Sentry / 自建 API
  }
}
