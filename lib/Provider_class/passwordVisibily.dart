import 'package:flutter/foundation.dart';

class PasswordVisibilty with ChangeNotifier {
  bool _is_visible = true;
  bool get is_visible => _is_visible;

  void setVisibilty() {
    _is_visible = !_is_visible;
    notifyListeners();
  }
}
