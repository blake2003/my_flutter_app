import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

/// GFAlertPage：示範使用 GFAlert + GFFloatingWidget
class GFAlertPage extends StatefulWidget {
  const GFAlertPage({Key? key}) : super(key: key);

  @override
  State<GFAlertPage> createState() => _GFAlertPageState();
}

class _GFAlertPageState extends State<GFAlertPage> {
  bool showblur = false;
  Widget alertWidget = const SizedBox();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          showblur = true;
          alertWidget = GFAlert(
            alignment: Alignment.center,
            title: 'GFAlert標題',
            content: const Text(
              'GFAlert內容部分，GFAlert需要搭配浮動組件GFFloatingWidget使用',
            ),
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
                  color: GFColors.DARK,
                  child: const Text(
                    '好的',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
          );
        });
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: GFColors.DARK,
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: const Icon(
              CupertinoIcons.back,
              color: GFColors.SUCCESS,
            ),
          ),
          title: const Text('GFAlert', style: TextStyle(fontSize: 17)),
          centerTitle: true,
        ),
        body: GFFloatingWidget(
          verticalPosition: 150,
          showBlurness: showblur,
          child: alertWidget,
        ),
      ),
    );
  }
}
