import 'package:flutter/material.dart';
import 'package:flutter_test1/export/data_export.dart'; // 範例：自行調整路徑
import 'package:flutter_test1/logger/app_logger.dart';
import 'package:flutter_test1/widgets/gfdrawer.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';

// 匯入我們剛才的 Provider
import 'package:flutter_test1/providers/gfalert_provider.dart';

/// MyHomePage：顯示一組地區清單並導向不同頁面，包含回頂部功能與提示框
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /// 監測地區清單
  final List<String> sites = [
    '馬公',
    '金門',
    '馬祖',
    '宜蘭',
    '陽明',
    '花蓮',
    '台東',
    '恆春',
    '屏東',
    '前金',
    '美濃',
    '台南',
    '新營',
    '嘉義',
    '朴子',
    '斗六',
    '南投',
    '彰化',
    '忠明',
    '豐原',
    '三義',
    '苗栗',
    '新竹',
    '竹東',
    '平鎮',
    '桃園',
    '萬華',
    '士林',
    '板橋',
    '汐止',
    '基隆',
    'allname'
  ];

  /// 滾動控制器
  final ScrollController _scrollController = ScrollController();

  /// 是否顯示「回頂部按鈕」
  bool _showBackTop = false;

  /// 日誌
  final log = AppLogger('MyHomePage');

  @override
  void initState() {
    super.initState();
    log.i('Initializing MyHomePage');

    // 進入頁面後延遲 700ms 顯示彈窗
    Future.delayed(const Duration(milliseconds: 700), () {
      context.read<GfAlertProvider>().showAlert(context);
      log.i('Alert displayed from Provider');
    });

    _initializeScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    log.i('Disposing MyHomePage');
    super.dispose();
  }

  /// 初始化 scrollController 並監聽滾動事件
  void _initializeScrollController() {
    _scrollController.addListener(() {
      setState(() {
        // 當滾動距離大於 200 時，顯示回頂部按鈕
        _showBackTop = _scrollController.position.pixels >= 200;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    /// Consumer 用來監聽彈窗狀態。
    /// 也可以用 Selector 或 watch，都可以。
    return Scaffold(
      backgroundColor: GFColors.WHITE,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          _buildGridView(),

          // 當 Provider 裡 isVisible == true 時，把它的 alertWidget 疊加顯示
          Consumer<GfAlertProvider>(
            builder: (ctx, gfAlert, child) {
              if (!gfAlert.isVisible) return const SizedBox();
              return gfAlert.alertWidget;
            },
          ),
        ],
      ),
      drawer: const GFDrawer(
        child: GfDrawer(), // 你自定義的 Drawer
      ),
      floatingActionButton: _showBackTop ? _buildFloatingActionButton() : null,
    );
  }

  /// 建立 AppBar
  GFAppBar _buildAppBar() {
    return GFAppBar(
      backgroundColor: GFColors.PRIMARY,
      title: const Text('空氣品質監測地區'),
      searchBar: true,
      searchHintText: '搜索你感興趣的地區',
      onTap: () {
        log.i('Search bar tapped');
      },
      onChanged: (value) {
        log.i('Search bar text changed: $value');
      },
      onSubmitted: (value) {
        String searchQuery = value.trim();
        log.i('Search bar submitted: $searchQuery');

        // 根據 sites 清單找出索引
        int index = sites.indexWhere((site) => site == searchQuery);
        if (index != -1) {
          // 計算該項目的行數，GridView 每行有2個元素
          int row = index ~/ 2;

          // 根據 MediaQuery 計算有效寬度，扣除水平間距
          double screenWidth = MediaQuery.of(context).size.width;
          const int crossAxisCount = 2;
          const double crossAxisSpacing = 3;
          const double mainAxisSpacing = 8;
          const double childAspectRatio = 1.5;
          double effectiveWidth =
              (screenWidth - (crossAxisCount - 1) * crossAxisSpacing) /
                  crossAxisCount;
          // 高度依據 childAspectRatio 計算
          double gridItemHeight = effectiveWidth / childAspectRatio;

          // offset 為前面 row 個網格行高度之和，加上行間距
          double offset = row * (gridItemHeight + mainAxisSpacing);
          log.i('Scrolling to offset: $offset');

          _scrollController.animateTo(
            offset,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeIn,
          );
        } else {
          log.i('沒有找到對應的地區: $searchQuery');
        }
      },
    );
  }

  /// 建立地區清單 GridView
  Widget _buildGridView() {
    return GridView.builder(
      controller: _scrollController,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 每行 2 個
        mainAxisSpacing: 8, // 每行間距
        crossAxisSpacing: 3, // 每列間距
        childAspectRatio: 1.5, // 每個格子的寬高比
      ),
      itemCount: sites.length,
      itemBuilder: (context, index) {
        final site = sites[index];
        return GFListTile(
          avatar: const GFAvatar(
            backgroundImage: AssetImage('images/taiwan.png'),
          ),
          title: Text(
            site,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            log.i('Tapped on site: $site');
            _navigateToPage(index);
          },
          color: Colors.black,
        );
      },
    );
  }

  /// 導航到對應頁面
  void _navigateToPage(int index) {
    final pageMap = {
      0: const HomePage1(), // 馬公
      1: const HomePage2(), // 金門
      2: const HomePage3(), // 馬祖
      3: const HomePage4(), // 宜蘭
      4: const HomePage5(), // 陽明
      5: const HomePage6(), // 花蓮
      6: const HomePage7(), // 台東
      7: const HomePage8(), // 恆春
      8: const HomePage9(), // 屏東
      9: const HomePage10(), // 前金
      10: const HomePage11(), // 美濃
      11: const HomePage12(), // 台南
      12: const HomePage13(), // 新營
      13: const HomePage14(), // 嘉義
      14: const HomePage15(), // 朴子
      15: const HomePage16(), // 斗六
      16: const HomePage17(), // 南投
      17: const HomePage18(), // 彰化
      18: const HomePage19(), // 忠明
      19: const HomePage20(), // 豐原
      20: const HomePage21(), // 三義
      21: const HomePage22(), // 苗栗
      22: const HomePage23(), // 新竹
      23: const HomePage24(), // 竹東
      24: const HomePage25(), // 平鎮
      25: const HomePage26(), // 桃園
      26: const HomePage27(), // 萬華
      27: const HomePage28(), // 士林
      28: const HomePage29(), // 板橋
      29: const HomePage30(), // 汐止
      30: const HomePage31(), // 基隆
    };

    if (pageMap.containsKey(index)) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => pageMap[index]!),
      );
    }
  }

  /// 建立「回到頂部」Floating Action Button
  FloatingActionButton _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        log.i('Back to top button pressed');
        try {
          _scrollController.animateTo(
            0.0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.decelerate,
          );
          log.i('Scroll to top animation started successfully');
        } catch (e, stack) {
          log.e('Error while scrolling to top', e, stack);
        }
      },
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 4),
            child: const Icon(
              Icons.vertical_align_top,
              size: 23,
              color: Color.fromARGB(159, 0, 0, 0),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 0),
            child: const Text(
              'Top',
              style: TextStyle(
                fontSize: 15,
                color: Color.fromARGB(255, 164, 161, 170),
              ),
            ),
          )
        ],
      ),
    );
  }
}
