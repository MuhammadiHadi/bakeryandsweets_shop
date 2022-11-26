import 'package:flutter/foundation.dart';

class CounterClass with ChangeNotifier {
  int _count = 0;
  int get count => _count;

  String? _string;
  String? get string => _string;

  void setCounter() {
    _count++;
    notifyListeners();
  }

  void decreaseCounder() {
    _count--;
    notifyListeners();
  }

  void setvalue(newvalue) {
    _string != newvalue;
  }
}
