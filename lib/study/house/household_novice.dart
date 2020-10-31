import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Household_Novice extends StatefulWidget {
  Household_Novice({Key key, this.saveIndex, this.sentencefullcount})
      : super(key: key);

  int saveIndex; // firestore에 저장된 가장 최근에 본 영어 문장 인덱스를 저장할 변수.
  int sentencefullcount; // novice 레벨의 영어문장 총 갯수

  @override
  _Household_NoviceState createState() => _Household_NoviceState();
}

class _Household_NoviceState extends State<Household_Novice> {
  BuildContext _context;

  //int _QuestionCount = ; // 영어 문장 인덱스&firestore에서 저장된 영어문장을 읽어올 때 사용되는 인덱스.
  int _selectedIndex = 1; // bottom navigation bar에서 사용할 변수

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    _context = context;

    print(widget.saveIndex + 1);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[200],
          title: Text(
            '집',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Stack(
          children: [
            BackgroundImage(context),
            Center(
              child: StreamBuilder<QuerySnapshot>(
                stream:
                    Firestore.instance.collection("house_novice").snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return Text("Error: ${snapshot.error}");
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(child: CircularProgressIndicator());
                    default:
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.cyan),
                          color: Colors.cyan,
                        ),
                        width: (screenSize.width) * 0.85,
                        height: height * 0.6,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: width * 0.05),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(40),
                                ),
                              ),
                              width: width * 0.3,
                              height: height * 0.05,
                              child: Padding(
                                child: Text(
                                  (widget.saveIndex + 1).toString() +
                                      ' / ' +
                                      widget.sentencefullcount.toString(),
                                  style: TextStyle(
                                      fontSize: width * 0.055,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                padding: EdgeInsets.only(top: height * 0.01),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: width * 0.05),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.deepPurple),
                                color: Colors.white,
                              ),
                              width: width * 0.73,
                              height: height * 0.40,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        0, width * 0.048, 0, width * 0.12),
                                    child: Text(
                                      snapshot.data
                                          .documents[widget.saveIndex]['text']
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: width * 0.055,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  Expanded(
                                      child: Divider(
                                    thickness: 0.3,
                                    color: Colors.black,
                                  )),
                                  Text(
                                    snapshot
                                        .data
                                        .documents[widget.saveIndex]
                                            ['translation']
                                        .toString(),
                                    style: TextStyle(
                                      fontSize: width * 0.048,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  Expanded(
                                    child: Container(),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(width * 0.012),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            // 이전 문장 보기, 즐겨찾기 추가, 다음문장보기 위젯의 시작.
                            Container(
                              padding: EdgeInsets.only(bottom: width * 0.048),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  ButtonTheme(
                                    minWidth: width * 0.2,
                                    height: height * 0.05,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: RaisedButton(
                                      onPressed: () {
                                        if (widget.saveIndex <
                                                widget.sentencefullcount &&
                                            widget.saveIndex > 0) {
                                          setState(() {
                                            widget.saveIndex--;
                                            updateIndex(widget.saveIndex);
                                          });
                                        } else {
                                          showAlertDialog(widget.saveIndex);
                                        }
                                      },
                                      child: Text(
                                        '이전 문장 보기',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      color: Colors.white,
                                      textColor: Colors.black,
                                    ),
                                  ),
                                  ButtonTheme(
                                    minWidth: width * 0.2,
                                    height: height * 0.05,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: RaisedButton(
                                      // 즐겨찾기 버튼 클릭 시, 현재 보고있는 level의 영어문장을 firestore의 즐겨찾기 컬렉션에 저장.
                                      onPressed: () {
                                        setState(() {
                                          Add_Favorite(
                                              snapshot
                                                  .data
                                                  .documents[widget.saveIndex]
                                                      ['text']
                                                  .toString(),
                                              snapshot
                                                  .data
                                                  .documents[widget.saveIndex]
                                                      ['translation']
                                                  .toString());
                                        });
                                      },
                                      child: Text(
                                        '즐겨찾기에 추가',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      color: Colors.white,
                                      textColor: Colors.black,
                                    ),
                                  ),
                                  ButtonTheme(
                                    minWidth: width * 0.2,
                                    height: height * 0.05,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: RaisedButton(
                                      onPressed: () {
                                        if (widget.saveIndex <
                                            widget.sentencefullcount - 1) {
                                          setState(() {
                                            widget.saveIndex++;
                                            updateIndex(widget.saveIndex);
                                          });
                                        } else {
                                          showAlertDialog(widget.saveIndex);
                                        }
                                      },
                                      child: Text(
                                        '다음 문장 보기',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      color: Colors.white,
                                      textColor: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 첫 문장 또는 마지막 문장에서 이전 or 다음 버튼을 눌렀을 시, 호출되는 함수.
  void showAlertDialog(int count) async {
    await showDialog(
      context: _context,
      barrierDismissible: false, // 반드시 탭 버튼을 누를건가
      builder: (BuildContext context) {
        if (count == widget.sentencefullcount - 1) {
          return AlertDialog(
            title: Text('마지막 문장입니다.'),
            //content: Text("하나의 문항만을 체크해 주셔야 \n다음화면으로 이동됩니다."),
            actions: <Widget>[
              FlatButton(
                child: Text('확인'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        } else {
          return AlertDialog(
            title: Text('첫 문장입니다.'),
            //content: Text("하나의 문항만을 체크해 주셔야 \n다음화면으로 이동됩니다."),
            actions: <Widget>[
              FlatButton(
                child: Text('확인'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        }
      },
    );
  }

  // 즐겨찾기에 추가했다는 걸 알려주는 토스트 메시지
  void flutterToast() {
    Fluttertoast.showToast(
      msg: '즐겨찾기 추가 완료',
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red[200],
      fontSize: 20.0,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  // 가장 최근에 본 문장의 index를 firestore에 저장.
  void updateIndex(int index) {
    Firestore.instance
        .collection("save_house_novice_index")
        .document("index")
        .updateData({
      'textIndex': index,
    });
  }

  // firestore의 favorite_novice에 데이터 추가. (즐겨찾기 클릭 시,)
  void Add_Favorite(String name, String description) {
    flutterToast();
    Firestore.instance.collection('favorite_novice').add({
      'text': name,
      'translation': description,
    });
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
