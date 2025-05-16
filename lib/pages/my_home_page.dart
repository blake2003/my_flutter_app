import 'package:flutter/material.dart';
import 'package:flutter_test1/Components/Widgets/back_to_top_notifier.dart';
// 匯入我們剛才的 Provider
import 'package:flutter_test1/Components/Widgets/gfalert_provider.dart';
import 'package:flutter_test1/Components/widgets/gfdrawer.dart';
import 'package:flutter_test1/export/data_export.dart'; // 範例：自行調整路徑
import 'package:flutter_test1/logger/app_logger.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';

/// MyHomePage：顯示一組地區清單並導向不同頁面，包含回頂部功能與提示框
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//TODO:手機版面顯示數量過多，需調整版面
//TODO:手機版面顯示數量過多，需調整版面，內容也是
//TODO: 做狀態管理，根據複雜度選擇 Provider 或 Riverpod
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

  /// 日誌
  final log = AppLogger('MyHomePage');

  @override
  void initState() {
    super.initState();
    log.i('Initializing MyHomePage');

    // 進入頁面後延遲 700ms 顯示彈窗
    Future.delayed(const Duration(milliseconds: 700), () {
      context.read<GfAlertProvider>().showAlert(
            context: context,
            title: "Welcome to the air quality monitoring area",
            content: const Text(
              'Are you ready to know how bad the air quality is?'
              'Click the button below to start monitoring the air quality of your area!',
            ),
          );
      log.i('Alert displayed from Provider');
    });
  }

  @override
  void dispose() {
    log.i('Disposing MyHomePage');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final backToTop = context.watch<BackToTopNotifier>();

    /// Consumer 用來監聽彈窗狀態。
    /// 也可以用 Selector 或 watch，都可以。
    return Scaffold(
      backgroundColor: GFColors.WHITE,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          _buildGridView(),
          // 這裡負責把 alertWidget 疊上去
          Selector<GfAlertProvider, bool>(
            selector: (_, provider) => provider.isVisible,
            builder: (context, isVisible, __) {
              // 當 isVisible 為 false 時直接返回空容器
              if (!isVisible) return const SizedBox();

              // 只有在 isVisible=true 時，才去讀一次 alertWidget
              // 這裡用 read 保證不再註冊額外的監聽
              final alert = context.read<GfAlertProvider>().alertWidget;
              return alert;
            },
          ),
        ],
      ),
      drawer: const GFDrawer(
        child: GfDrawer(), // 你自定義的 Drawer
      ),
      floatingActionButton: backToTop.showBackTop
          ? _buildFloatingActionButton(backToTop.scrollController)
          : null,
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
        final controller = context.read<BackToTopNotifier>().scrollController;

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

          controller.animateTo(
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
    // 使用 Provider 來獲取 BackToTopNotifier
    final backToTop = context.watch<BackToTopNotifier>();

    return GridView.builder(
      controller: backToTop.scrollController,
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
              fontWeight: FontWeight.normal,
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
  FloatingActionButton _buildFloatingActionButton(ScrollController controller) {
    final controller = context.read<BackToTopNotifier>().scrollController;

    return FloatingActionButton(
      onPressed: () {
        log.i('Back to top button pressed');
        try {
          controller.animateTo(
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
        mainAxisSize: MainAxisSize.min, // 讓 Column 只撐住內容高度
        mainAxisAlignment: MainAxisAlignment.center, // 置中排版
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
                fontSize: 13,
                color: Color.fromARGB(255, 164, 161, 170),
              ),
            ),
          )
        ],
      ),
    );
  }
}
