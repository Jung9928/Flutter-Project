import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPw extends StatefulWidget {
  @override
  _ForgetPwState createState() => _ForgetPwState();
}

class _ForgetPwState extends State<ForgetPw> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // 로그인 Form 위젯 내에 TextFormField 위젯에서 사용자가 입력하는 id, pw 정보를
  // 저장할 변수 선언.
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Forget Password'),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.account_circle),
                    labelText:
                        "이메일", // labelText는 TextFormField 내에 부가설명을 붙여넣는 용도로 사용함.
                  ),
                  // 로그인 폼에 있는 email 작성란에 사용자가 email을 작성하면 그 정보를 가져옴.
                  // 가져온 정보를 value 변수에 저장.
                  validator: (String value) {
                    // 올바르지 않은 email 입력 or 입력을 아에 안했을 경우
                    if (value.isEmpty) {
                      return "올바른 이메일을 입력하세요.";
                    }
                    // 올바르게 email 입력한 경우
                    return null;
                  }),
              FlatButton(
                  onPressed: () async {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: _emailController.text);
                    final snacBar = SnackBar(
                      content: Text('비밀번호 초기화 전에 이메일이 맞는지 확인해주세요.'),
                    );
                    Scaffold.of(_formKey.currentContext).showSnackBar(snacBar);
                  },
                  child: Text('비밀번호 초기화'))
            ],
          ),
        ));
  }
}
