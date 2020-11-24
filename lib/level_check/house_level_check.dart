import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/study/house/household_advanced.dart';
import 'package:flutter_firebase_login/study/house/household_intermediate.dart';
import 'package:flutter_firebase_login/study/house/household_novice.dart';

class HouseLevelCheck extends StatefulWidget {
  HouseLevelCheck({this.uid});

  final String uid;

  @override
  _HouseLevelCheckState createState() => _HouseLevelCheckState();
}

class _HouseLevelCheckState extends State<HouseLevelCheck> {
  BuildContext _context;
  bool _novice = false;
  bool _intermediate = false;
  bool _advanced = false;
  int _count = 0; // 레벨 체크에서 체크가 된 횟수 저장
  int _index = 0; // 최근에 봤던 영어문장의 index를 저장할 변수
  int _sentencefullcount = 0;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    _context = context;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[200],
          title: Text(
            '집 난이도 선택',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.red[200]),
              color: Colors.red[200],
            ),
            width: (screenSize.width) * 0.85,
            height: width * 1.2,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: width * 0.05),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.red[200]),
                    color: Colors.white,
                  ),
                  width: width * 0.73,
                  height: width * 0.49,
                  child: ListView(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(
                            0, height * 0.025, 0, width * 0.12),
                        height: height * 0.3,
                        child: Text(
                          'OPIc 주제 별 문장 학습을 \n진행하기 전에 원하는 \n난이도를 선택해 주세요. \n\n선택하신 난이도에 맞는 문장을 \n학습하실 수 있습니다',
                          style: TextStyle(
                            fontSize: width * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: width * 0.05),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.red[200]),
                    color: Colors.white,
                  ),
                  width: width * 0.73,
                  height: width * 0.41,
                  child: ListView(
                    //padding: EdgeInsets.only(bottom: width * 0.048),
                    children: [
                      CheckboxListTile(
                        title: Text(
                          'NL~NH 수준의 문장을 원해요.',
                          style: TextStyle(
                            fontSize: width * 0.029,
                          ),
                        ),
                        value: _novice,
                        onChanged: (bool value) {
                          setState(() {
                            _novice = value;
                            if (_novice == true)
                              _count++;
                            else
                              _count--;
                          });
                        },
                        secondary: Icon(
                          Icons.hourglass_empty,
                          size: width * 0.055,
                        ),
                      ),
                      CheckboxListTile(
                        title: Text('IL~IH 수준의 문장을 원해요.',
                            style: TextStyle(
                              fontSize: width * 0.029,
                            )),
                        value: _intermediate,
                        onChanged: (bool value) {
                          setState(() {
                            _intermediate = value;
                            if (_intermediate == true)
                              _count++;
                            else
                              _count--;
                          });
                        },
                        secondary:
                            Icon(Icons.hourglass_empty, size: width * 0.055),
                      ),
                      CheckboxListTile(
                        title: Text('AL 수준의 문장을 원해요.',
                            style: TextStyle(
                              fontSize: width * 0.029,
                            )),
                        value: _advanced,
                        onChanged: (bool value) {
                          setState(() {
                            _advanced = value;
                            if (_advanced == true)
                              _count++;
                            else
                              _count--;
                          });
                        },
                        secondary:
                            Icon(Icons.hourglass_empty, size: width * 0.055),
                      ),
                    ],
                  ),
                ),
//                Expanded(
//                  child: Container(),
//                ),
                Padding(
                  padding: EdgeInsets.only(bottom: width * 0.05),
                ),
                Flexible(
                  child: Container(
                    padding: EdgeInsets.only(bottom: width * 0.048),
                    child: ButtonTheme(
                      minWidth: width * 0.73,
                      height: height * 0.05,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),

                      // 체크한 level에 맞는 route로 이동.
                      child: RaisedButton(
                        onPressed: () async {
                          if (_count == 1 && _novice == true) {
                            await showAlertNoviceDataLoadDialog();
                            Navigator.push(context, MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                              return Household_Novice(
                                saveIndex: _index,
                                sentencefullcount: _sentencefullcount,
                                uid: widget.uid,
                              );
                            }));
                          } else if (_count == 1 && _intermediate == true) {
                            await showAlertImDataLoadDialog();
                            Navigator.push(context, MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                              return Household_Intermediate(
                                saveIndex: _index,
                                sentencefullcount: _sentencefullcount,
                                uid: widget.uid,
                              );
                            }));
                          } else if (_count == 1 && _advanced == true) {
                            await showAlertAlDataLoadDialog();
                            Navigator.push(context, MaterialPageRoute<void>(
                                builder: (BuildContext context) {
                              return Household_Advanced(
                                saveIndex: _index,
                                sentencefullcount: _sentencefullcount,
                                uid: widget.uid,
                              );
                            }));
                          } else {
                            showAlertDialog();
                          }
                        },
                        child: Text(
                          '학습 하러 가기',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        color: Colors.white,
                        textColor: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // firestore에서 "집안일 거들기"에서 novice 레벨의 document들 갯수를 count하는 함수.
  void countHouseNovice() async {
    QuerySnapshot _myDoc =
        await Firestore.instance.collection('house_novice').getDocuments();
    List<DocumentSnapshot> _myDocCount = _myDoc.documents;
    _sentencefullcount = _myDocCount.length;
  }

  // firestore에서 "집안일 거들기"에서 intermediate 레벨의 document들 갯수를 count하는 함수.
  void countHouseIM() async {
    QuerySnapshot _myDoc = await Firestore.instance
        .collection('house_intermediate')
        .getDocuments();
    List<DocumentSnapshot> _myDocCount = _myDoc.documents;
    _sentencefullcount = _myDocCount.length;
  }

  // firestore에서 "집안일 거들기"에서 advanced 레벨의 document들 갯수를 count하는 함수.
  void countHouseAL() async {
    QuerySnapshot _myDoc =
        await Firestore.instance.collection('house_advanced').getDocuments();
    List<DocumentSnapshot> _myDocCount = _myDoc.documents;
    _sentencefullcount = _myDocCount.length;
  }

  // firestore에서 최근에 봤던 영어 문장의 index가 저장된 데이터를 읽어옴.
  void getHouseNoviceIndexData() async {
    await Firestore.instance
        .collection(widget.uid + '_save_house_novice_index')
        .document('index')
        .get()
        .then((idx) {
      _index = idx.data['textIndex'];
      print(_sentencefullcount);
    });
  }

  // firestore에서 최근에 봤던 영어 문장의 index가 저장된 데이터를 읽어옴.
  void getHouseIMIndexData() async {
    await Firestore.instance
        .collection(widget.uid + '_save_house_intermediate_index')
        .document('index')
        .get()
        .then((idx) {
      _index = idx.data['textIndex'];
      print(_sentencefullcount);
    });
  }

  // firestore에서 최근에 봤던 영어 문장의 index가 저장된 데이터를 읽어옴.
  void getHouseALIndexData() async {
    await Firestore.instance
        .collection(widget.uid + '_save_house_al_index')
        .document('index')
        .get()
        .then((idx) {
      _index = idx.data['textIndex'];
      print(_sentencefullcount);
    });
  }

  void showAlertDialog() async {
    await showDialog(
      context: _context,
      barrierDismissible: false, // 선택지 외의 공간을 눌렀을 때, 반응 안하도록 설정
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('체크문항 경고'),
          content: Text("하나의 문항만을 체크해 주셔야 \n다음화면으로 이동됩니다."),
          actions: <Widget>[
            FlatButton(
              child: Text('확인'),
              onPressed: () async {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  // Novice level 데이터 얻기 확인/취소 dialog
  Future<void> showAlertNoviceDataLoadDialog() async {
    // Navigator.pop에 2개의 메소드 호출은 불가하니 여기서 호출하여 dialog 팝업 시, firestore에 데이터 요청.
    countHouseNovice();
    await showDialog(
      context: _context,
      barrierDismissible: false, // 반드시 탭 버튼을 눌러야 함
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('데이터 불러오기 알림'),
          content: Text("가장 최근에 학습한 영어문장을 저장소에서\n가져오시겠습니까?"),
          actions: <Widget>[
            FlatButton(
              child: Text('데이터 가져오기'),
              onPressed: () {
                Navigator.pop(context, getHouseNoviceIndexData());
              },
            ),
            FlatButton(
              child: Text('취소'),
              onPressed: () {
                _index = 0;
                Navigator.pop(context, countHouseNovice());
              },
            ),
          ],
        );
      },
    );
  }

  // IM level 데이터 얻기 확인/취소 dialog
  Future<void> showAlertImDataLoadDialog() async {
    // Navigator.pop에 2개의 메소드 호출은 불가하니 여기서 호출하여 dialog 팝업 시, firestore에 데이터 요청.
    countHouseIM();
    await showDialog(
      context: _context,
      barrierDismissible: false, // 반드시 탭 버튼을 눌러야 함
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('데이터 불러오기 알림'),
          content: Text("가장 최근에 학습한 영어문장을 저장소에서\n가져오시겠습니까?"),
          actions: <Widget>[
            FlatButton(
              child: Text('데이터 가져오기'),
              onPressed: () {
                Navigator.pop(context, getHouseIMIndexData());
              },
            ),
            FlatButton(
              child: Text('취소'),
              onPressed: () {
                _index = 0;
                Navigator.pop(context, countHouseIM());
              },
            ),
          ],
        );
      },
    );
  }

  // AL level 데이터 얻기 확인/취소 dialog
  Future<void> showAlertAlDataLoadDialog() async {
    // Navigator.pop에 2개의 메소드 호출은 불가하니 여기서 호출하여 dialog 팝업 시, firestore에 데이터 요청.
    countHouseAL();
    await showDialog(
      context: _context,
      barrierDismissible: false, // 반드시 탭 버튼을 눌러야 함
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('데이터 불러오기 알림'),
          content: Text("가장 최근에 학습한 영어문장을 저장소에서\n가져오시겠습니까?"),
          actions: <Widget>[
            FlatButton(
              child: Text('데이터 가져오기'),
              onPressed: () {
                Navigator.pop(context, getHouseALIndexData());
              },
            ),
            FlatButton(
              child: Text('취소'),
              onPressed: () {
                _index = 0;
                Navigator.pop(context, countHouseAL());
              },
            ),
          ],
        );
      },
    );
  }
}
