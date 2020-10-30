import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/data/join_or_login.dart';
import 'package:flutter_firebase_login/screens/login.dart';
import 'package:flutter_firebase_login/screens/main_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // JoinOrLogin형의 데이터를 AuthPage에 제공하는 Provider를 생성.
      // 이렇게 Provider를 제공하면 위젯트리 상에서 AuthPage부터 아래의 모든 자식 위젯들은
      // Provider에 접근 가능.
      home: Splash(),
      //routes: routes,
    );
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 사용자가 login, logout을 했을 경우, 그 정보를 FirebaseUser 타입으로 받아옴.
    return StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot) {
          // snapshot.data는 firebase 유저의 login 유무 정보임.
          // null이면 login이 안된 상태.
          if (snapshot.data == null) {
            return ChangeNotifierProvider<JoinOrLogin>.value(
                value: JoinOrLogin(),
                // 이 JoinOrLogin이라는 값은 AuthPage 위젯부터 아래 모든 자식위젯들에 접근 가능.

                // 앱을 실행하면 바로 AuthPage로 감.
                child: AuthPage());
          } else {
            return MainPage(
                email: snapshot.data.email); // login이 되었을 경우, MainPage로 감.
          }
        });
  }
}
