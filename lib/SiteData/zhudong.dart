import 'package:flutter/material.dart';
import '../logger/app_logger.dart';
import '../Services/site_data_service.dart';
import 'package:getwidget/getwidget.dart';

class HomePage24 extends StatefulWidget {
  const HomePage24({super.key});

  @override
  State<HomePage24> createState() => _HomePageState(); // ← 回傳公有型別
}

class _HomePageState extends State<HomePage24> {
  List<dynamic> records = [];
  final log = AppLogger('zhudong');

  Future<void> _fetchData() async {
    try {
      records = await DataService.fetchSiteData('竹東');
      setState(() {});
    } catch (e) {
      log.e('竹東未加載成功', e);
      // Handle error
    }
  }

  Color _getColor(double concentration) {
    if (concentration <= 15.4) {
      return Colors.green;
    } else if (concentration <= 35.4) {
      return Colors.yellow;
    } else if (concentration <= 54.4) {
      return Colors.orange;
    } else if (concentration <= 150.4) {
      return Colors.red;
    } else {
      return Colors.purple;
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('PM2.5濃度'),
      ),
      body: Center(
        child: records.isEmpty
            ? const CircularProgressIndicator()
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 每行 2 固定兩個網格
                  mainAxisSpacing: 8, // 每行間距
                  crossAxisSpacing: 3, // 與上方參數相反，表示 horizontal 項目的間距
                  childAspectRatio: 3, // 每個格子的寬高比
                ),
                itemCount: records.length,
                itemBuilder: (context, index) {
                  double concentration =
                      double.parse(records[index]['concentration'].toString());
                  Color color = _getColor(concentration);
                  return GFListTile(
                    title: Text(records[index]['sitename'],
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                    subTitle: Text(
                        '監測濃度: ${records[index]['concentration']} ${records[index]['itemunit']} 日期: ${records[index]['monitordate']}',
                        style: TextStyle(color: color, fontSize: 17)),
                    //dense: false, //true使文字變小
                    color: Colors.black,
                  );
                },
              ),
      ),
    );
  }
}
