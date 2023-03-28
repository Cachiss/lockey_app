import 'package:flutter/foundation.dart';

class TopicValueProvider with ChangeNotifier {
  //value of lock/unlock
  bool _lock = false;
  bool get lock => _lock;
  set lock(bool value) {
    print("value from set lock: $value");
    _lock = value;
    notifyListeners();
  }
}
