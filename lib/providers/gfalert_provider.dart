import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:logging/logging.dart';

class GfAlertProvider extends ChangeNotifier {
  bool _isVisible = false; // 判斷是否顯示彈窗
  Widget _alertWidget = const SizedBox(); // 彈窗 widget

  bool get isVisible => _isVisible;
  Widget get alertWidget => _alertWidget;

  final Logger _logger = Logger('GfAlertProviderLogger');

  /// 顯示彈窗
  void showAlert(BuildContext context) {
    _isVisible = true;

    // 可以在這裡組合出你想顯示的彈窗內容，也可以把這段抽到一個方法。
    _alertWidget = _buildSampleAlert(context);

    notifyListeners();
  }

  /// 隱藏彈窗
  void hideAlert() {
    _isVisible = false;
    _alertWidget = const SizedBox();
    notifyListeners();
    _logger.info('Hide pressed');
  }

  /// 範例：可將彈窗的組裝邏輯抽到這個 private method
  Widget _buildSampleAlert(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          child: Container(
            color: Colors.black.withOpacity(0.3),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
        ),
        // 彈窗本體
        GFFloatingWidget(
          verticalPosition: 150,
          showBlurness: false,
          body: Column(
            children: [
              const SizedBox(height: 220),
              Container(
                margin: const EdgeInsets.only(top: 20),
                color: Colors.transparent,
                child: Center(
                  child: GFAlert(
                    alignment: Alignment.center,
                    backgroundColor: Colors.white,
                    title: 'Welcome!',
                    content: const Text(
                      'Get Flutter is one of the largest Flutter open-source UI library...',
                    ),
                    type: GFAlertType.rounded,
                    bottomBar: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        GFButton(
                          onPressed: hideAlert,
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
        ),
      ],
    );
  }
}
