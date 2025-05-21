import 'package:flutter/material.dart';
import 'package:flutter_test1/Core/Constants/app_colors.dart';
import 'package:flutter_test1/Core/Constants/homepage_size.dart';
import 'package:flutter_test1/Logger/app_logger.dart';
import 'package:flutter_test1/State_provider/SiteData_state/multi_site_provider.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';

class HomePage31 extends StatelessWidget {
  static const String routeName = '/keelung';
  const HomePage31({super.key});

  Color _getColor(double c) => AppColors.getAqiColor(c);

  Future<void> _fetchData(BuildContext context) async {
    final log = AppLogger('keelung');
    try {
      log.i('開始獲取基隆數據');
      await context.read<MultiSiteProvider>().fetchAll(['基隆']);
      log.i('基隆數據獲取成功');
    } catch (e) {
      log.e('基隆未加載成功', e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final log = AppLogger('keelung');
    log.i('構建基隆页面');

    final provider = context.watch<MultiSiteProvider>();
    final records = provider.recordsOf('基隆') ?? [];

    log.i('獲取到基隆紀錄数: ${records.length}');

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
                  crossAxisCount: HomePageSize.gridCrossAxisCount,
                  mainAxisSpacing: HomePageSize.gridMainAxisSpacing,
                  crossAxisSpacing: HomePageSize.gridCrossAxisSpacing,
                  childAspectRatio: HomePageSize.gridChildAspectRatio,
                ),
                itemCount: records.length,
                itemBuilder: (_, i) {
                  final r = records[i];
                  final c = double.parse(r['concentration'].toString());
                  log.d(
                      '顯示紀錄 #$i: ${r['sitename']}, 濃度: ${r['concentration']}');

                  return GFListTile(
                    color: Colors.black,
                    title: Text(r['sitename'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: HomePageSize.titleFont,
                        )),
                    subTitle: Text(
                      '監測濃度: ${r['concentration']} ${r['itemunit']}'
                      '  日期: ${r['monitordate']}',
                      style: TextStyle(
                          color: _getColor(c),
                          fontSize: HomePageSize.subtitleFont),
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _fetchData(context),
        backgroundColor: Colors.blue,
        elevation: 8.0,
        tooltip: '刷新數據',
        child: const Icon(
          Icons.refresh,
          color: Colors.white,
          size: HomePageSize.fabIconSize,
        ),
      ),
    );
  }
}
