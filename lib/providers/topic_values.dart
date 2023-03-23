import 'package:flutter/foundation.dart';

class TopicValueProvider with ChangeNotifier {
  //value of lock/unlock
  bool _lock = false;
  bool get lock => _lock;
  set lockValue(bool value) {
    _lock = value;
    notifyListeners();
  }
}
