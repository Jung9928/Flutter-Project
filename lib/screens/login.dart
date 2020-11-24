import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/data/join_or_login.dart';
import 'package:flutter_firebase_login/helper/login_background.dart';
import 'package:flutter_firebase_login/screens/forgot_pw.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  // flutter 프레임워크에 내장된 추상클래스 GlobalKey를 사용하여
  // 이 코드에서는 Form 위젯에만 부여되는 유니크한 키를 생성.
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // 로그인 Form 위젯 내에 TextFormField 위젯에서 사용자가 입력하는 id, pw 정보를
  // 저장할 변수 선언.
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // MediaQuery를 사용하여 Size 클래스의 size변수에 저장된 스마트폰의 화면 크기 정보를 얻어와서
    // Size 클래스 타입인 size변수에 저장.
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CustomPaint(
            size: size,
            // Provider를 적용시키고 싶은 LoginBackground 위젯에 Provider.of()를 사용하여
            // 상태가 변할 경우, LoginBackground 위젯이 알림을 받을 listener 라고 지정.
            // 상태값은 isJoin 이며, 상태값의 타입은 JoinOrLogin 타입임.
            painter: LoginBackground(
                isJoin: Provider.of<JoinOrLogin>(context).isJoin),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // 네트워크 상에서 이미지를 가져온다. 뒤에 200은 이미지 크기임.
              // Image.network("https://picsum.photos/200"),

              /* placeholder를 사용하면 image에서 화면에 표현할 이미지를 로딩하는 동안
                 placeholder에 지정한 이미지를 대신 보여준 후, 원래의 표현할 이미지가 로딩이 완료되면
                 FadeIn 효과를 내며 사라진다.
              FadeInImage.assetNetwork(
                  placeholder: "assets/loading.gif",
                  image: "https://picsum.photos/200"),
                  
              */
              // Expanded는 자신의 영역에서 위젯을 세로 축으로 자신의 영역의 최대치로 늘린다.
              _logoImage, // _logoImage 위젯에서 get을 사용했기에 ( )괄호 생략 가능.
              Stack(
                children: <Widget>[
                  _inputForm(size),
                  _authButton(size),
                  //Container(
                  //eight: size.height * 0.1,
                  //),
                ],
              ),
              Container(
                height: size.height * 0.1,
              ),
              Consumer<JoinOrLogin>(
                builder: (BuildContext context, joinOrLogin, child) =>
                    GestureDetector(
                  onTap: () {
                    // Consumer를 사용하여 사용자가 "Don't Have an Account?~~" 텍스트를 한번만 누르면
                    // 그에 대한 상태 변경 정보를 가진 JoinOrLogin 클래스에 대해 Cumsumer를 사용하여
                    // 상태 정보를 가져와 joinOrLogin 변수에 저장하고, 이 변수를 통해 JoinOrLogin 클래스의
                    // toggle 함수를 호출하여 notifyListeners 를 통해 Provider를 사용하는 모든 위젯에게
                    // 상태 변경에 대한 알림을 전달하게 됨.
                    // JoinOrLogin joinOrLogin = Provider.of<JoinOrLogin>(context);
                    joinOrLogin.toggle();
                  },
                  child: Text(
                    joinOrLogin.isJoin
                        ? "\t\t\t\t\t 이미 계정을 갖고 계신가요?? \n가지고 계신 계정으로 로그인하세요."
                        : "계정이 없으신가요?? \n새 계정을 생성하세요.",
                    style: TextStyle(
                        color: joinOrLogin.isJoin ? Colors.red : Colors.blue),
                  ),
                ),
              ),
              Container(
                height: size.height *
                    0.05, // MediaQuery 클래스를 이용하여 얻은 화면 사이즈값이 저장된 변수 size 사용.
              ),
            ],
          ),
        ],
      ),
    );
  }

  // FirebaseAuth는 Future 클래스이므로 async와 await를 사용해야 함.
  // 계정 생성 루틴
  void _register(BuildContext context) async {
    final AuthResult result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
    final FirebaseUser user = result.user;
    final FirebaseUser uid = await FirebaseAuth.instance.currentUser();

    if (user == null) {
      final snacBar = SnackBar(
        content: Text('Please try again later.'),
      );
      Scaffold.of(context).showSnackBar(snacBar);
    }
  }

  // Login 버튼 누를 시,
  void _login(BuildContext context) async {
    final AuthResult result = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
    final FirebaseUser user = result.user;

    if (user == null) {
      loginError_Toast();
    } else {
      login_Toast();
    }
  }

  // get을 사용하면 위젯을 호출할 때, _logoImage()에서 괄호없이 코드작성이 가능하다.
  // _logoImage 이런식으로 위젯 호출 가능.
  Widget get _logoImage => Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 24, right: 24),
          // FittedBox의 BoxFit.contain은 자신의 영역의 정가운데에 위젯을 위치시킨 후 최대한 크기를 늘린다.
          child: FittedBox(
            fit: BoxFit.contain,
            // 이미지를 원형의 모양으로 설정.
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/main_page.jpg"),
            ),
          ),
        ),
      );

  // => 는 중괄호랑 같은 의미임. 그냥 간단하게 표현이 대체된 것 뿐.
  Widget _authButton(Size size) => Positioned(
        left: size.width * 0.1,
        right: size.width * 0.1,
        bottom: 0,

        // Login 버튼 생성
        child: SizedBox(
          height: 50,
          child: Consumer<JoinOrLogin>(
            builder: (context, jointOrLogin, child) => RaisedButton(
              child: Text(
                jointOrLogin.isJoin ? "계정생성" : "로그인",
              ),
              color: jointOrLogin.isJoin ? Colors.red[200] : Colors.blueAccent,
              // Login 버튼 모양 설정
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              onPressed: () {
                // global key로 생성한 _formKey를 통해 Form 위젯의 현재 상태정보(TextFormField의 validator 정보를 가져옴.)
                // validator에는 사용자가 입력한 email, pw정보가 입력되었는지 아닌지에 대한 bool 값을 가지고 있음.
                if (_formKey.currentState.validate()) {
                  // 로그인 화면이면.
                  jointOrLogin.isJoin ? _register(context) : _login(context);
                }
              },
            ),
          ),
        ),
      );

  Widget _inputForm(Size size) {
    // Card 위젯 크기를 모든 방향에서 줄임.
    return Padding(
      padding: EdgeInsets.all(size.width * 0.05),
      // Form 위젯을 Card 형태로 만듬
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6, // 카드형태가 된 Form 위젯에 그림자 효과 부여.

        // Card 위젯 내에 있는 Form 위젯에 Padding 위젯을 사용하여
        // Card 위젯과 Form 위젯 사이의 간격을 조절.
        child: Padding(
          padding:
              const EdgeInsets.only(left: 12.0, right: 12, top: 12, bottom: 32),
          child: Form(
              // Form 위젯에만 부여되는 유니크한 글로벌 키 _formKey
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment
                    .start, // Forgot Password 텍스트의 위치를 왼쪽으로 정렬.
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
                        return "올바른 이메일을 입력해주세요.";
                      }
                      // 올바르게 email 입력한 경우
                      return null;
                    },
                  ),
                  TextFormField(
                    obscureText: true, // 패스워드 입력 시, *모양으로 표시
                    controller: _passwordController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.vpn_key),
                      labelText: "비밀번호",
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "올바른 비밀번호를 입력해주세요.";
                      }
                      return null;
                    },
                  ),
                  Container(
                    height: 8,
                  ),
                  Consumer<JoinOrLogin>(
                      builder: (context, value, child) => Opacity(
                          opacity: value.isJoin ? 0 : 1,
                          child: GestureDetector(
                              onTap: value.isJoin
                                  ? null
                                  : () {
                                      goToForgetPW(context);
                                    },
                              child: Text("비밀번호 찾기")))),
                ],
              )),
        ),
      ),
    );
  }

  // 로그인 여부를 알려주는 토스트 메시지
  void login_Toast() {
    Fluttertoast.showToast(
      msg: '로그인 성공',
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red[200],
      fontSize: 20.0,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  // 로그인 여부를 알려주는 토스트 메시지
  void loginError_Toast() {
    Fluttertoast.showToast(
      msg: '로그인 실패\n다시 입력해 주세요.',
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red[200],
      fontSize: 20.0,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  void goToForgetPW(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ForgetPw()));
  }
}
