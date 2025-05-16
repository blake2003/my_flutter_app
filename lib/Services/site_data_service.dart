// data_service.dart
import 'dart:convert';

import 'package:http/http.dart' as http;

class DataService {
  static const String _apiUrl =
      'https://data.moenv.gov.tw/api/v2/aqx_p_10?api_key='
      'e8dd42e6-9b8b-43f8-991e-b3dee723a52d&limit=1000'
      '&sort=monitordate%20desc&format=JSON';

  // 傳入 sitename，回傳篩選後的資料
  static Future<List<dynamic>> fetchSiteData(String siteName) async {
    final response = await http.get(Uri.parse(_apiUrl));
    if (response.statusCode == 200) {
      final decoded = utf8.decode(response.bodyBytes);
      final map = json.decode(decoded);
      final records = map['records'] as List<dynamic>? ?? [];
      return records.where((r) => r['sitename'] == siteName).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
