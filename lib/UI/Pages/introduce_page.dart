import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:url_launcher/url_launcher.dart';

/// IntroducePage：介紹頁面，包含簡易折疊卡片與提示框
class IntroducePage extends StatefulWidget {
  const IntroducePage({Key? key}) : super(key: key);

  @override
  State<IntroducePage> createState() => _IntroducePageState();
}

class _IntroducePageState extends State<IntroducePage> {
  /// 彈窗
  Widget alertWidget = const SizedBox();
  bool showblur = false;

  @override
  void initState() {
    super.initState();
    _showAlert();
  }

  /// 隱藏提示框
  void _hideAlert() {
    setState(() {
      alertWidget = const SizedBox();
      showblur = false;
    });
  }

  /// 顯示提示框
  void _showAlert() {
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        alertWidget = GFFloatingWidget(
          verticalPosition: 150,
          showBlurness: showblur,
          body: Column(
            children: [
              const SizedBox(height: 180),
              Container(
                margin: const EdgeInsets.only(top: 20),
                color: Colors.transparent,
                child: Center(
                  child: GFAlert(
                    alignment: Alignment.center,
                    backgroundColor: Colors.white,
                    title: 'Welcome!',
                    content: const Text(
                      'Get Flutter is one of the largest Flutter open-source '
                      'UI library for mobile or web apps with  1000+ pre-built reusable widgets.',
                    ),
                    type: GFAlertType.rounded,
                    bottomBar: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        GFButton(
                          onPressed: _hideAlert,
                          color: GFColors.LIGHT,
                          child: const Text(
                            'Close',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          child: alertWidget,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IntroducePage'),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          const MyAccordionList(), // 自定義的摺疊卡片清單
          alertWidget,
        ],
      ),
    );
  }
}

/// MyAccordionList：展示基本的 GFAccordion 實例
class MyAccordionList extends StatelessWidget {
  const MyAccordionList({Key? key}) : super(key: key);

  Future<void> _openUrl(BuildContext context) async {
    // 在 await 之前，就同步「取用」一次 messenger
    final messenger = ScaffoldMessenger.of(context);

    final uri = Uri.parse('https://data.moenv.gov.tw/dataset/detail/aqx_p_10');

    final success = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
    if (!success) {
      messenger.showSnackBar(
        SnackBar(content: Text('無法開啟 $uri')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const GFAccordion(
        title: 'GF Accordion',
        content: '這是一個預設樣式的折疊卡片.',
      ),
      const GFAccordion(
        titleChild: GFTypography(text: '個人資料'),
        expandedTitleBackgroundColor: Colors.amber,
        contentBackgroundColor: Colors.blueAccent,
        collapsedIcon: Text('展開'),
        expandedIcon: Text('收起'),
        contentChild: GFListTile(
          titleText: '小黑',
          subTitleText: 'Flutter新手小白',
          icon: Icon(
            Icons.favorite,
            color: Colors.red,
          ),
          color: Colors.transparent,
          avatar: GFAvatar(
            backgroundImage: AssetImage('images/cat.jpeg'),
          ),
        ),
      ),
      GFAccordion(
        title: '測站資料來源',
        contentChild: RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: "資料來源: ",
                style: TextStyle(color: Colors.red),
              ),
              WidgetSpan(
                child: GestureDetector(
                  onTap: () => _openUrl(context),
                  child: const Text(
                    '點擊跳轉',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
