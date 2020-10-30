import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/favorite/favorite_al/level_al.dart';
import 'package:flutter_firebase_login/favorite/favorite_im/level_im.dart';
import 'package:flutter_firebase_login/favorite/favorite_novice/level_novice.dart';

class favoriteNovice extends StatefulWidget {
  favoriteNovice({Key key, this.favoriteNoviceCount}) : super(key: key);
  int favoriteNoviceCount;
  int favoriteIMCount;
  int favoriteALCount;

  @override
  _favoriteNoviceState createState() => _favoriteNoviceState();
}

class _favoriteNoviceState extends State<favoriteNovice> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    countFavoriteNovice('favorite_novice');
    countFavoriteIM('favorite_intermediate');
    countFavoriteAL('favorite_al');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[200],
        title: Text(
          '즐겨찾기 목록',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          BackgroundImage(context), // 배경 이미지를 희미하게 삽입.
          StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection("house_novice")
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) return Text("Error: ${snapshot.error}");
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  return ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            width * 0.02, height * 0.03, width * 0.02, 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            child: Container(
                              height: 70,
                              color: Colors.grey[50],
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    color: Colors.red[200],
                                    width: 70,
                                    height: 70,
                                    child: Icon(Icons.spa, color: Colors.white),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('NL~NH 문장',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20)),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(right: width * 0.05),
                                    child: Container(
                                      width: width * 0.2,
                                      height: width * 0.07,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Colors.black38),
                                      padding:
                                          EdgeInsets.only(top: width * 0.012),
                                      child: Text(
                                        widget.favoriteNoviceCount.toString() +
                                            ' 문장',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute<void>(
                                  builder: (BuildContext context) {
                                return LevelNovice(
                                  favoriteFullCount: widget.favoriteNoviceCount,
                                );
                              }));
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            width * 0.02, height * 0.03, width * 0.02, 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            child: Container(
                              height: 70,
                              color: Colors.grey[50],
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    color: Colors.red[200],
                                    width: 70,
                                    height: 70,
                                    child: Icon(Icons.spa, color: Colors.white),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('IL~IM 문장',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20)),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(right: width * 0.05),
                                    child: Container(
                                      width: width * 0.2,
                                      height: width * 0.07,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Colors.black38),
                                      padding:
                                          EdgeInsets.only(top: width * 0.012),
                                      child: Text(
                                        widget.favoriteIMCount.toString() +
                                            ' 문장',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute<void>(
                                  builder: (BuildContext context) {
                                return LevelIm();
                              }));
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            width * 0.02, height * 0.03, width * 0.02, 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            child: Container(
                              height: 70,
                              color: Colors.grey[50],
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    color: Colors.red[200],
                                    width: 70,
                                    height: 70,
                                    child: Icon(Icons.spa, color: Colors.white),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text('AL 문장',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20)),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(right: width * 0.05),
                                    child: Container(
                                      width: width * 0.2,
                                      height: width * 0.07,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: Colors.black38),
                                      padding:
                                          EdgeInsets.only(top: width * 0.012),
                                      child: Text(
                                        widget.favoriteALCount.toString() +
                                            ' 문장',
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute<void>(
                                  builder: (BuildContext context) {
                                return LevelAl();
                              }));
                            },
                          ),
                        ),
                      ),
                    ],
                  );
              }
            },
          ),
        ],
      ),
    );
  }

//  // firestore에서 최근에 봤던 영어 문장의 index가 저장된 데이터를 읽어옴.
//  void getNumber() {
//    Firestore.instance.collection('save').document('index').get().then((idx) {
//      _indexOfFavorite = idx.data['textIndex'];
//    });
//  }

  // firestore에서 즐겨찾기에 저장된 novice 레벨의 document들 갯수를 count하는 함수.
  void countFavoriteNovice(docID) async {
    QuerySnapshot _myDoc =
        await Firestore.instance.collection(docID).getDocuments();
    List<DocumentSnapshot> _myDocCount = _myDoc.documents;
    widget.favoriteNoviceCount = _myDocCount.length;
  }

  // firestore에서 즐겨찾기에 저장된 Intermediate 레벨의 document들 갯수를 count하는 함수.
  void countFavoriteIM(docID) async {
    QuerySnapshot _myDoc =
        await Firestore.instance.collection(docID).getDocuments();
    List<DocumentSnapshot> _myDocCount = _myDoc.documents;
    widget.favoriteIMCount = _myDocCount.length;
  }

  // firestore에서 즐겨찾기에 저장된 AL 레벨의 document들 갯수를 count하는 함수.
  void countFavoriteAL(docID) async {
    QuerySnapshot _myDoc =
        await Firestore.instance.collection(docID).getDocuments();
    List<DocumentSnapshot> _myDocCount = _myDoc.documents;
    widget.favoriteALCount = _myDocCount.length;
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
