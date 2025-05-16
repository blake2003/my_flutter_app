// back_to_top_notifier.dart
import 'package:flutter/widgets.dart';

class BackToTopNotifier extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();

  bool _showBackTop = false;
  bool get showBackTop => _showBackTop;

  BackToTopNotifier() {
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final shouldShow = scrollController.offset >= 200;
    if (shouldShow != _showBackTop) {
      _showBackTop = shouldShow;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }
}
