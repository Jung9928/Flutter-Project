import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/favorite/favorite_list.dart';
import 'package:flutter_firebase_login/script/script_page.dart';
import 'package:flutter_firebase_login/study/study_page.dart';
import 'package:flutter_firebase_login/study_management/studymanagement.dart';
import 'package:flutter_firebase_login/youtube_screens/home_screen.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class MainPage extends StatefulWidget {
  // MainPage 위젯 생성 시, 생성자로 email 값을 가져옴.
  MainPage({this.email});

  final String email;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  BuildContext _context;
  // BottomNavBar에서 클릭한 Icon의 인덱스
  int _selectedIndex = 0;
  static int _favoriteFullCount = 0; // main 페이지에서 즐겨찾기 리스트 페이지에 나타낼 문장 갯수.

  final List<String> imgList = [
    'https://opic.or.kr/opics/files/upload/tms/opicinformation/OPIcInformationServlet_maxtrixfile1_201010180903161_.gif',
    'https://opic.or.kr/opics/files/upload/tms/opicinformation/OPIcInformationServlet_maxtrixfile1_201010180905231_.gif',
    'https://opic.or.kr/opics/files/upload/tms/opicinformation/OPIcInformationServlet_maxtrixfile1_201010180905051_.gif',
  ];

  // bottomnavigationbar에서 각 버튼 클릭 시, return할 위젯들
  final List<Widget> _bottomList = [
    HomeScreen(),
    favoriteNovice(
        favoriteNoviceCount:
            _favoriteFullCount), // static 박아뒀기 때문에 호출 가능. 근데 올바른 방법은 아닌 것 같음.
    Management()
  ];

  // BottomNavigationBar에서 버튼 클릭 시, _bottomList에 지정된 위젯들을 index에 따라 이동.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      Navigator.push(context,
          MaterialPageRoute<void>(builder: (BuildContext context) {
        return _bottomList[_selectedIndex];
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    countFavoriteNovice();
//    countNovice();
//    getSaveData();

    return Scaffold(
      resizeToAvoidBottomInset:
          false, // 화면에서 keyboard가 올라올 시, 화면을 밀어내어 발생하는 overflow pixel 문제를 해결.
      appBar: AppBar(
        backgroundColor: Colors.red[200],
        title: Text(
          '모두의 오픽',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/opic.png'),
                backgroundColor: Colors.white,
              ),
              accountEmail: Text(widget.email + '님 반가워요'), // 가져온 email 값 출력
              onDetailsPressed: () {},
              decoration: BoxDecoration(
                color: Colors.red[200],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.question_answer, color: Colors.grey[850]),
              title: Text('문의하기'),
              onTap: () {
                print('hhhh');
              },
              trailing: Icon(Icons.add),
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app, color: Colors.grey[850]),
              title: Text('로그아웃'),
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
              trailing: Icon(Icons.add),
            ),
          ],
        ),
      ),
      body: Stack(
        children: <Widget>[
          BackgroundImage(context), // 배경 이미지를 희미하게 삽입.
          Container(
            height: 400,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Swiper(
                autoplay: true,
                scale: 0.9,
                viewportFraction: 1.5,
                pagination: SwiperPagination(alignment: Alignment.bottomRight),
                itemCount: imgList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Image.network(imgList[index]);
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                width * 0.02, height * 0.44, width * 0.02, 0),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.border_color),
                    title: Text(
                      '나만의 스크립트를 작성해봐요',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ButtonTheme(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: RaisedButton(
                          child: const Text(
                            '작성 하러가기',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          color: Colors.grey[300],
                          onPressed: () {
                            Navigator.push(context, CupertinoPageRoute<void>(
                                builder: (BuildContext context) {
                              return Make_Script();
                            }));
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                width * 0.02, height * 0.56, width * 0.02, 0),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.audiotrack),
                    title: Text(
                      'OPIc 유튜브 영상도 있어요',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ButtonTheme(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: RaisedButton(
                          child: const Text(
                            '영상 보러가기',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          color: Colors.grey[300],
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                              return HomeScreen();
                            }));
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
                width * 0.02, height * 0.68, width * 0.02, 0),
            child: Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const ListTile(
                    leading: Icon(Icons.school),
                    title: Text(
                      '주제 별로 학습하러 가요',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ButtonTheme(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: RaisedButton(
                          child: const Text(
                            '학습 하러가기',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          color: Colors.grey[300],
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                              return StudyPage();
                            }));
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('홈'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('즐겨찾기'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.web),
            title: Text('학습관리'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: _onItemTapped,
      ),
    );
  }

  // firestore에서 즐겨찾기에 저장된 "집안일 거들기"에서 novice 레벨의 document들 갯수를 count하는 함수.
  void countFavoriteNovice() async {
    QuerySnapshot _myDoc =
        await Firestore.instance.collection('favorite_novice').getDocuments();
    List<DocumentSnapshot> _myDocCount = _myDoc.documents;
    _favoriteFullCount = _myDocCount.length;
  }
}

// 배경 이미지를 희미하게 삽입.
Widget BackgroundImage(BuildContext context) {
  return Container(
    decoration: new BoxDecoration(
      image: new DecorationImage(
        fit: BoxFit.fill,
        image: const AssetImage("assets/main_page.jpg"),
        colorFilter: new ColorFilter.mode(
            Colors.white.withOpacity(0.3), BlendMode.dstATop),
      ),
    ),
  );
}
