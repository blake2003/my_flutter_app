import 'package:flutter/material.dart';
import 'package:flutter_test1/UI/Pages/introduce_page.dart';
import 'package:flutter_test1/UI/Pages/my_home_page.dart';
import 'package:getwidget/getwidget.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('我的介面'),
      ),
      body: SizedBox(
        width: 600,
        height: 220,
        child: GFCard(
          boxFit: BoxFit.fill,
          showOverlayImage: true,
          imageOverlay:
              const AssetImage('images/pexels-pixabay-background.jpeg'),
          title: const GFListTile(
            avatar: GFAvatar(
              backgroundImage: AssetImage('images/cat.jpeg'),
            ),
            titleText: '小黑',
            subTitleText: 'Flutter新手小白',
          ),
          content: const Text(
            "這裡是空氣品質專區",
            style: TextStyle(fontSize: 15),
          ),
          buttonBar: GFButtonBar(
            children: <Widget>[
              GFButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const IntroducePage()));
                }, //做個小介紹，然後放上資料來源與參考資料
                text: '介紹',
              ),
              GFButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => const MyHomePage()));
                },
                text: '點擊跳轉',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
//暫時放置用不到