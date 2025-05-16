import 'package:flutter/material.dart';
import 'package:flutter_test1/SiteData/Provider/multi_site_provider.dart';
import 'package:flutter_test1/logger/app_logger.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';

class HomePage6 extends StatelessWidget {
  static const String routeName = '/hualien';
  const HomePage6({super.key});

  Color _getColor(double c) {
    if (c <= 15.4) return Colors.green;
    if (c <= 35.4) return Colors.yellow;
    if (c <= 54.4) return Colors.orange;
    if (c <= 150.4) return Colors.red;
    return Colors.purple;
  }

  Future<void> _fetchData(BuildContext context) async {
    final log = AppLogger('hualien');
    try {
      log.i('开始获取花莲数据');
      await context.read<MultiSiteProvider>().fetchAll(['花蓮']);
      log.i('花莲数据获取成功');
    } catch (e) {
      log.e('花蓮未加載成功', e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final log = AppLogger('hualien');
    log.i('构建花莲页面');
    
    final provider = context.watch<MultiSiteProvider>();
    final records = provider.recordsOf('花蓮') ?? [];
    
    log.i('获取到花莲记录数: ${records.length}');

    return Scaffold(
      appBar:
          AppBar(backgroundColor: Colors.blue, title: const Text('PM2.5 濃度')),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () => _fetchData(context),
              child: GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 3,
                  childAspectRatio: 3,
                ),
                itemCount: records.length,
                itemBuilder: (_, i) {
                  final r = records[i];
                  final c = double.parse(r['concentration'].toString());
                  log.d('显示记录 #$i: ${r['sitename']}, 浓度: ${r['concentration']}');

                  return GFListTile(
                    color: Colors.black,
                    title: Text(r['sitename'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 45,
                        )),
                    subTitle: Text(
                      '監測濃度: ${r['concentration']} ${r['itemunit']}'
                      '  日期: ${r['monitordate']}',
                      style: TextStyle(color: _getColor(c), fontSize: 23),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _fetchData(context),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
