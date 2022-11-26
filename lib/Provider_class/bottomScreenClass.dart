import 'package:flutter/foundation.dart';

class BottomScreenClass with ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void setCurrentIndex(value) {
    _currentIndex = value;
    notifyListeners();
  }
}
