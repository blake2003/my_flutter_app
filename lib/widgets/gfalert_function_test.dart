import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class CustomAlertDialog {
  static Widget alertWidget = const SizedBox();
  static bool showblur = false;

  static void hideAlert() {
    alertWidget = const SizedBox();
    showblur = false;
  }

  static GestureDetector showOverlay(BuildContext context) {
    return GestureDetector(
      onTap: () {}, // 空的點擊事件，防止點擊穿透
      child: Container(
        color: Colors.black.withOpacity(0.5), // 半透明黑色
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      ),
    );
  }

  static void showAlert(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 700), () {
      alertWidget = Stack(
        children: [
          // 遮罩層
          GestureDetector(
            onTap: () {}, // 空的點擊事件，防止點擊穿透
            child: Container(
              color: Colors.black.withOpacity(0.5), // 半透明黑色
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          GFFloatingWidget(
            verticalPosition: 150,
            showBlurness: showblur,
            body: Column(
              children: [
                const SizedBox(height: 220),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  color: Colors.transparent,
                  child: const Center(
                    child: GFAlert(
                      alignment: Alignment.center,
                      backgroundColor: Colors.white,
                      title: 'Welcome!',
                      content: Text(
                          'Get Flutter is one of the largest Flutter open-source UI library for mobile or web apps with  1000+ pre-built reusable widgets.'),
                      type: GFAlertType.rounded,
                      bottomBar: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          GFButton(
                            onPressed: hideAlert,
                            color: GFColors.LIGHT,
                            child: Text(
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
          ),
        ],
      );
    });
  }
}
