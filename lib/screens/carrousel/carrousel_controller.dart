import 'package:flutter/cupertino.dart';
import 'package:thunderapp/screens/screens_index.dart';
import 'package:thunderapp/shared/core/navigator.dart';

class CarrouselScreenController with ChangeNotifier {
  final PageController _pageController =
      PageController(initialPage: 0);
  int _currentPageIndex = 0;
  final int _lastPageIndex = 3;
  PageController get pageController => _pageController;
  int get currentPageIndex => _currentPageIndex + 1;

  void changePageIndex(int index) {
    _currentPageIndex = index;
    changePage(_currentPageIndex);
  }

  void nextPage() {
    _currentPageIndex++;
    _pageController.nextPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.bounceIn);
    if (isLastPage()) {
      Navigator.pushNamed(
          navigatorKey.currentContext!, Screens.signin);
    }
  }

  bool isLastPage() {
    if (_currentPageIndex >= _lastPageIndex) {
      return true;
    } else {
      return false;
    }
  }

  void previousPage() {
    _currentPageIndex--;
    _pageController.previousPage(
        duration: const Duration(milliseconds: 200),
        curve: Curves.bounceIn);
  }

  void changePage(int index) {
    nextPage();
    notifyListeners();
  }
}
