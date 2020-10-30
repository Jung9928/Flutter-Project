import 'package:flutter/material.dart';

class LoginBackground extends CustomPainter {
  // LoginBackground 클래스의 생성자
  LoginBackground({this.isJoin});

  final bool isJoin;

  @override
  void paint(Canvas canvas, Size size) {
    // Paint 객체의 color 값을 blueAccent로 설정한 후, 변수 paint에 저장.
    // a = b = c; 와 같은 개념인데 아래의 경우는 Paint().. << 이 .(점)이 2개인게 핵심.
    // .을 포인터라 생각하면 됨.
    Paint paint = Paint()..color = isJoin ? Colors.red : Colors.blueAccent;
    // 첫 번째 인자 값 : 크기, 2번째 인자 값 : 반지름 , 3번째 인자 값 : 적용할 변수.
    canvas.drawCircle(
        Offset(size.width * 0.5, size.height * 0.2), size.height * 0.5, paint);
  }

  @override
  // 움직이는 그림은 초당 60프레임으로 애니메이션되어 동작되는데
  // 이것에 맞춰서 뒤에 파란색 background를 똑같이 60프레임으로 그려줄거냐 말거냐를 선택.
  // false를 지정해서 동작시키지 않음.
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
