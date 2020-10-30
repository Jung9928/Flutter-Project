import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class JoinOrLogin extends ChangeNotifier {
  bool _isJoin = false; // _isJoin을 private 변수로 선언. why?

  bool get isJoin => _isJoin;

  // toggle 함수가 실행될 때마다, _isjoin 변수 값을 false <-> true로 바꿈.
  void toggle() {
    _isJoin = !_isJoin;
    // ChangeNotifierProvider 클래스를 통해서 제공되는 데이터가 저장된 isJoin 값이 변경될 때마다
    // _isJoin 변수를 사용하고 있는 위젯(구독자, listener)들에게 값이 변경되었음을 알려줌.
    notifyListeners();
  }
}
