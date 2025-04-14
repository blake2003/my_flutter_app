import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test1/widgets/gfalert_function_test.dart';
import 'package:getwidget/getwidget.dart';

class TestPage1 extends StatefulWidget {
  const TestPage1({Key? key}) : super(key: key);
  @override
  State<TestPage1> createState() => _TestPage1PageState();
}

class _TestPage1PageState extends State<TestPage1> {
  late Widget alertWidget;
  bool showblur = false;
  @override
  void initState() {
    super.initState();
    alertWidget = const SizedBox();
    _showAlert();
  }

  void _hideAlert() {
    setState(() {
      alertWidget = const SizedBox();
      showblur = false;
    });
  }

  void _showAlert() {
    setState(() {
      alertWidget = GFFloatingWidget(
        verticalPosition: 150,
        showBlurness: showblur,
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              color: Colors.transparent,
              child: Center(
                child: GFAlert(
                  alignment: Alignment.center,
                  backgroundColor: Colors.white,
                  title: 'Welcome!',
                  content: const Text(
                      'Get Flutter is one of the largest Flutter open-source UI library for mobile or web apps with  1000+ pre-built reusable widgets.'),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _GFAppBar(context),
      body: Stack(children: [
        CustomAlertDialog.alertWidget,
      ]),
    );
  }
/*
  @override
  void initState() {
    super.initState();
    //方法二
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        showblur = true;
        alertWidget = GFAlert(
          alignment: Alignment.center,
          backgroundColor: Colors.white,
          title: 'Welcome!',
          content: const Text(
              'Get Flutter is one of the largest Flutter open-source UI library for mobile or web apps with  1000+ pre-built reusable widgets.'),
          type: GFAlertType.rounded,
          bottomBar: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              GFButton(
                onPressed: () {
                  setState(() {
                    alertWidget = SizedBox();
                    showblur = false;
                  });
                },
                color: GFColors.LIGHT,
                child: const Text(
                  'Close',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        );
      });
    });
  }
*/
  //var _showblur = false;
  /*
  @override
  void initState() {
    super.initState();
    // 避免调用Alert时没有加载完父级页面，延迟1秒调用
    Timer(Duration(seconds: 1), () => _getUserIsAuthentication());
  }

  _getUserIsAuthentication(){
    if(!_showblur){
      AlertMsg.alertDialog(context, '你还没有实名认证呦，赶快认证成为主播或专家吧', '立即认证', '先不认证', (){
        Navigator.pop(context);
        Navigator.pushNamed(context, '/myAuthentication');
      });
    }
  }
  */

  GFAppBar _GFAppBar(BuildContext context) {
    return GFAppBar(
      backgroundColor: GFColors.PRIMARY,
      leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            CupertinoIcons.back,
            color: GFColors.SUCCESS,
          )),
      title: const Text(
        'Animation',
        style: TextStyle(fontSize: 17),
      ),
      centerTitle: true,
    );
  }

  GFFloatingWidget _GFFloatingWidget() {
    return GFFloatingWidget(
        verticalPosition: 150,
        showBlurness: showblur,
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20),
              color: Colors.transparent,
              child: Center(
                child: GFButton(
                    text: 'Tap to View',
                    onPressed: () {
                      setState(() {
                        showblur = true;
                        alertWidget = GFAlert(
                          alignment: Alignment.center,
                          backgroundColor: Colors.white,
                          title: 'Welcome!',
                          content: const Text(
                              'Get Flutter is one of the largest Flutter open-source UI library for mobile or web apps with  1000+ pre-built reusable widgets.'),
                          type: GFAlertType.rounded,
                          bottomBar: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              GFButton(
                                onPressed: () {
                                  setState(() {
                                    alertWidget = const SizedBox();
                                    showblur = false;
                                  });
                                },
                                color: GFColors.LIGHT,
                                child: const Text(
                                  'Close',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                    }),
              ),
            ),
          ],
        ),
        child: alertWidget);
  }
}



/*
作者：Haoyu
链接：https://juejin.cn/post/7081298839323279373
来源：稀土掘金
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
*/