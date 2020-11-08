import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LevelAl extends StatefulWidget {
  LevelAl({Key key, this.favoriteFullCount}) : super(key: key);

  int favoriteFullCount; // 즐겨찾기에 저장된 영어문장 총 개수
  @override
  _LevelAlState createState() => _LevelAlState();
}

class _LevelAlState extends State<LevelAl> {
  BuildContext _context;
  int indexOfFavoriteNovice =
      0; // 현재 firestore에 저장된 favorite_novice 컬렉션의 데이터 index

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
            'AL 수준의 즐겨찾기 문장',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Stack(
          children: [
            BackgroundImage(context),
            Center(
              child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection("favorite_novice")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return Text("Error: ${snapshot.error}");
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Text("Loading...");
                    default:
                      if (widget.favoriteFullCount == 0) {
                        return Container(
                          child: Text('즐겨찾기에 추가한 영어문장이 없습니다.'),
                        );
                      } else {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.red[200]),
                            color: Colors.red[200],
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
                                    (indexOfFavoriteNovice + 1).toString() +
                                        ' / ' +
                                        widget.favoriteFullCount.toString(),
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
                                  border: Border.all(color: Colors.red[200]),
                                  color: Colors.white,
                                ),
                                width: width * 0.73,
                                height: height * 0.45,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.fromLTRB(
                                          0, width * 0.048, 0, width * 0.18),
                                      child: Text(
                                        snapshot
                                            .data
                                            .documents[indexOfFavoriteNovice]
                                                ['text']
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
                                          .documents[indexOfFavoriteNovice]
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
                                          if (indexOfFavoriteNovice > 0) {
                                            setState(() {
                                              indexOfFavoriteNovice--;
                                            });
                                          } else {
                                            showAlertDialog(
                                                indexOfFavoriteNovice);
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
//                                    ButtonTheme(
//                                      minWidth: width * 0.2,
//                                      height: height * 0.05,
//                                      shape: RoundedRectangleBorder(
//                                        borderRadius: BorderRadius.circular(10),
//                                      ),
//                                      child: RaisedButton(
//                                        onPressed: () {
////                                          showAlertDeleteFavoriteDialog(
////                                              Firestore.instance
////                                                  .collection(
////                                                  'favorite_novice')
////                                                  .document()
////                                                  .get()
////                                                  .toString());
//                                        },
//                                        child: Text(
//                                          '즐겨찾기 삭제',
//                                          style: TextStyle(
//                                              fontWeight: FontWeight.bold),
//                                        ),
//                                        color: Colors.white,
//                                        textColor: Colors.black,
//                                      ),
//                                    ),
                                    ButtonTheme(
                                      minWidth: width * 0.2,
                                      height: height * 0.05,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: RaisedButton(
                                        onPressed: () {
                                          if (indexOfFavoriteNovice <
                                              widget.favoriteFullCount - 1) {
                                            setState(() {
                                              indexOfFavoriteNovice++;
                                            });
                                          } else {
                                            showAlertDialog(
                                                indexOfFavoriteNovice);
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
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 즐겨찾기 삭제.
  void deleteFavorite(text, translation) {
    Firestore.instance
        .collection('favorite_novice')
        .document(getDocumentID(text, translation))
        .delete();
  }

  getDocumentID(String text, String translation) {
    return Firestore.instance
        .collection('favorite_novice')
        .where('text', isEqualTo: text)
        .where('translation', isEqualTo: translation)
        .getDocuments();
  }

  // 첫 문장 또는 마지막 문장에서 이전 or 다음 버튼을 눌렀을 시, 호출되는 함수.
  void showAlertDialog(int count) async {
    await showDialog(
      context: _context,
      barrierDismissible: false, // 반드시 탭 버튼을 누를건가
      builder: (BuildContext context) {
        if (count == widget.favoriteFullCount - 1) {
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
          print(widget.favoriteFullCount);
          print(count);
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

  Future<void> showAlertDeleteFavoriteDialog(text, translation) async {
    await showDialog(
      context: _context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('즐겨찾기 삭제 경고'),
          content: Text("정말 삭제하시겠습니까?\n삭제된 즐겨찾기는 복구되지 않습니다."),
          actions: <Widget>[
            FlatButton(
              child: Text('삭제'),
              onPressed: () {
                deleteFavorite(text, translation);
                Navigator.pop(context, "삭제");
              },
            ),
            FlatButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.pop(context, "취소");
              },
            ),
          ],
        );
      },
    );
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
