// data_service.dart
import 'dart:convert';

import 'package:flutter_test1/Logger/app_logger.dart';
import 'package:http/http.dart' as http;

class DataService {
  static final log = AppLogger('DataService');

  static const String _apiUrl =
      'https://data.moenv.gov.tw/api/v2/aqx_p_10?api_key='
      'e8dd42e6-9b8b-43f8-991e-b3dee723a52d&limit=1000'
      '&sort=monitordate%20desc&format=JSON';

  // 傳入 sitename，回傳篩選後的資料
  static Future<List<dynamic>> fetchSiteData(String siteName) async {
    try {
      final response = await http.get(Uri.parse(_apiUrl));
      if (response.statusCode == 200) {
        final decoded = utf8.decode(response.bodyBytes);
        final map = json.decode(decoded);
        final records = map['records'] as List<dynamic>? ?? [];
        final filteredRecords =
            records.where((r) => r['sitename'] == siteName).toList();

        if (filteredRecords.isEmpty) {
          log.w('⚠️ 沒有找到 $siteName 的資料');
        }

        return filteredRecords;
      } else {
        log.e('❌ API 請求失敗: ${response.statusCode} - ${response.reasonPhrase}');
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e, stackTrace) {
      log.e('❌ 資料抓取錯誤: $e', e, stackTrace);
      throw Exception('資料抓取失敗: $e');
    }
  }
}

//TODO: 檢查資料抓取問題，無法抓取資料
