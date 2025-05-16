import 'package:flutter/material.dart';
import 'package:flutter_test1/SiteData/Provider/multi_site_provider.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';

class HomePage29 extends StatelessWidget {
  static const String routeName = '/banqiao';
  const HomePage29({super.key});

  Color _getColor(double c) {
    if (c <= 15.4) return Colors.green;
    if (c <= 35.4) return Colors.yellow;
    if (c <= 54.4) return Colors.orange;
    if (c <= 150.4) return Colors.red;
    return Colors.purple;
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MultiSiteProvider>();
    final records = provider.recordsOf('板橋') ?? [];

    return Scaffold(
      appBar:
          AppBar(backgroundColor: Colors.blue, title: const Text('PM2.5 濃度')),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () =>
                  context.read<MultiSiteProvider>().fetchAll(['板橋']),
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
        onPressed: () => context.read<MultiSiteProvider>().fetchAll(['板橋']),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
