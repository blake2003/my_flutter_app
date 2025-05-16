import 'package:flutter/material.dart';
import 'package:flutter_test1/Services/site_data_service.dart';

class MultiSiteProvider extends ChangeNotifier {
  final Map<String, List<dynamic>> _records = {};
  bool _loading = false;
  bool get isLoading => _loading;

  List<dynamic>? recordsOf(String site) => _records[site];

  Future<void> fetchAll(List<String> sites) async {
    _loading = true;
    notifyListeners();

    try {
      // 並行抓取
      final futures = sites.map((site) async {
        try {
          final data = await DataService.fetchSiteData(site);
          _records[site] = data;
        } catch (e, stackTrace) {
          debugPrint('❌ $site 資料讀取失敗: $e\n$stackTrace');
          _records[site] = []; // 失敗時清空該站點資料
        }
      });

      await Future.wait(futures);
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  /// 清除指定站点的數據
  void clearSite(String site) {
    _records.remove(site);
    notifyListeners();
  }

  /// 清除所有站点的數據
  void clearAll() {
    _records.clear();
    notifyListeners();
  }
}
