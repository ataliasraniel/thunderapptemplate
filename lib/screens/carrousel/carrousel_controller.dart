import 'package:flutter/cupertino.dart';
import 'package:thunderapp/screens/screens_index.dart';
import 'package:thunderapp/shared/core/navigator.dart';

class CarrouselScreenController with ChangeNotifier {
  final PageController _pageController = PageController(initialPage: 0);
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
    changePage(_currentPageIndex);
    if (isLastPage()) {
      //you should use the navigator key to change routes
      Navigator.pushNamed(navigatorKey.currentContext!, Screens.home);
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
    changePage(_currentPageIndex);
  }

  void changePage(int index) {
    _pageController.animateToPage(index, duration: const Duration(milliseconds: 200), curve: Curves.easeInBack);
    notifyListeners();
  }
}
