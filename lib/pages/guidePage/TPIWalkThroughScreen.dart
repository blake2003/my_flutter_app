import 'package:flutter_test1/pages/my_home_page.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test1/pages/guidePage/TPIColors.dart';
import 'package:flutter_test1/pages/guidePage/TPIDataProvider.dart';
import 'package:flutter_test1/pages/guidePage/TPIWalkThroughData.dart';
import 'package:flutter_test1/pages/guidePage/TPIString.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:logging/logging.dart';

class TPIWalkThroughScreen extends StatefulWidget {
  const TPIWalkThroughScreen({super.key});

  @override
  TPIWalkThroughScreenState createState() => TPIWalkThroughScreenState();
}

class TPIWalkThroughScreenState extends State<TPIWalkThroughScreen> {
  final Logger _logger = Logger('TPIWalkThroughScreen'); // 初始化 Logger 用於除錯和日誌記錄
  PageController controller = PageController(); // 控制頁面滑動
  List<TPIWalkThroughData> list = tpiWalkThroughDataList(); // 儲存引導頁的資料
  int currentPageIndex = 0; // 記錄當前顯示的頁面索引

  @override
  void initState() {
    super.initState();
    _logger.info('初始化 TPIWalkThroughScreen'); // 初始化時記錄日誌
  }

  @override
  void dispose() {
    controller.dispose(); // 銷毀 PageController 以釋放資源
    _logger.info('TPIWalkThroughScreen 被銷毀'); // 銷毀時記錄日誌
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tpiPrimaryColor, // 設置背景色
      body: Stack(
        children: [
          ScrollConfiguration(
            behavior: const ScrollBehavior(),
            child: PageView(
              controller: controller, // 使用 PageController 控制頁面
              children: list.map(_buildPage).toList(), // 根據資料生成頁面
              onPageChanged: (index) {
                setState(() {
                  currentPageIndex = index; // 當頁面改變時更新當前頁面索引
                });
                _logger.fine('頁面變更至索引: $currentPageIndex'); // 記錄頁面變換的索引
              },
            ),
          ),
          _buildFooter(context), // 底部的控制按鈕
          _buildSkipButton(context), // 略過按鈕
        ],
      ),
    );
  }

  // 用於構建每個頁面的 widget
  Widget _buildPage(TPIWalkThroughData page) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 540, // 設定圖片顯示區域的高度
          width: 460, // 設定圖片顯示區域的寬度
          child: FittedBox(
            fit: BoxFit.contain, // 讓圖片適應容器大小
            child: Image.asset(
              page.imagePath,
              fit: BoxFit.contain,
              errorBuilder:
                  (BuildContext context, Object error, StackTrace? stackTrace) {
                _logger.severe('圖片加載失敗: $error', error, stackTrace);
                return const Icon(Icons.error, color: Colors.red); // 顯示錯誤圖示
              },
            ), // 顯示圖片
          ),
        ),
        const SizedBox(height: 48), // 頁面間隔
        Text(
          page.title,
          style: const TextStyle(fontSize: 24, color: Colors.white),
        ), // 顯示標題
        const SizedBox(height: 16), // 頁面間隔
        Text(
          page.subtitle,
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ), // 顯示副標題
      ],
    );
  }

  // 底部的導航區域，顯示分頁指示器和"開始使用"按鈕
  Widget _buildFooter(BuildContext context) {
    return Positioned(
      bottom: 30,
      left: 16,
      right: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DotsIndicator(
            dotsCount: 3, // 設定分頁點的數量
            position: currentPageIndex, // 根據當前頁面索引顯示分頁點
          ),
          Visibility(
            visible: currentPageIndex == list.length - 1, // 當在最後一頁時顯示“開始使用”按鈕
            maintainState: true,
            maintainAnimation: true,
            maintainSize: true,
            child: GFButton(
              color: Colors.white,
              onPressed: () {
                _logger.info('用戶點擊了“開始使用”按鈕'); // 記錄用戶點擊開始使用
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const MyHomePage()), // 轉跳到主頁
                );
              },
              child: Text(tpiGetStarted,
                  style: TextStyle(color: tpiPrimaryColor)), // 按鈕文字
            ),
          ),
        ],
      ),
    );
  }

  // 顯示"略過"按鈕
  Widget _buildSkipButton(BuildContext context) {
    return Positioned(
      top: 40,
      right: 16,
      child: Visibility(
        visible: currentPageIndex < list.length - 1, // 當不在最後一頁時顯示“略過”按鈕
        child: GestureDetector(
          onTap: () {
            _logger.info('用戶跳過了引導頁'); // 記錄用戶跳過引導頁
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const MyHomePage()), // 轉跳到主頁
            );
          },
          child: const Padding(
            padding: EdgeInsets.only(top: 8, right: 8),
            child: Text(tpiSkip,
                style: TextStyle(color: Colors.white)), // 顯示“略過”文字
          ),
        ),
      ),
    );
  }
}
