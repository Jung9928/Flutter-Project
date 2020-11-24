import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/script/view_script.dart';
import 'package:flutter_firebase_login/script/write_script.dart';

class Make_Script extends StatefulWidget {
  Make_Script({this.uid});

  final String uid; // 로그인한 사용자의 firebase uid 값.

  @override
  _Make_ScriptState createState() => _Make_ScriptState();
}

class _Make_ScriptState extends State<Make_Script> {
  BuildContext _context;
  String docID;
  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[200],
        title: Text(
          '저장된 스크립트 목록',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        // MediaQuery를 사용했을 때 발생하는 overflow 문제를 ListView 위젯으로 해결.
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection(widget.uid + "_script")
                  .orderBy('scriptDate',
                      descending:
                          true) // 가장 최근에 저장한 내용을 최상단에 노출할 수 있게 정렬하여 데이터를 가져옴.
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) return Text("Error: ${snapshot.error}");
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator(
                        semanticsLabel: 'Loading...',
                      ),
                    );
                  default:
                    // 생성한 스크립트가 없는 경우 화면에 표시할 안내글
                    if (snapshot.data.documents.isEmpty) {
                      return Container(
                        alignment: Alignment.center,
                        child: Text(
                          '지금 바로 "스크립트 추가" 버튼을 눌러\n 새 스크립트를 추가해보세요!\n\n\n\n\n\n\n\n',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                          textAlign: TextAlign.center,
                        ),
                      );
                    } else {
                      return ListView(
                        children: snapshot.data.documents
                            .map((DocumentSnapshot document) {
                          Timestamp tt = document["scriptDate"];
                          DateTime dt = DateTime.fromMillisecondsSinceEpoch(
                              tt.millisecondsSinceEpoch);

                          return InkWell(
                            onTap: () {
                              // 스크립트를 클릭하면 스크립트 수정 페이지로 이동
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ViewPage(
                                            title: document["scriptTitle"],
                                            text: document["scriptText"],
                                            date: dt.toString(),
                                            docID: document.documentID,
                                            uid: widget.uid,
                                          )));
                            },
                            onLongPress: () {
                              showAlertDialog(document.documentID);
                            },
                            child: Container(
                                margin: EdgeInsets.all(5),
                                padding: EdgeInsets.all(15),
                                alignment: Alignment.center,
                                height: 100,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Text(
                                          document["scriptTitle"],
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          document["scriptText"],
                                          style: TextStyle(fontSize: 15),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Text(
                                            "최종 수정 시간: " +
                                                dt.toString().split('.')[0],
                                            style: TextStyle(fontSize: 11),
                                            textAlign: TextAlign.end),
                                      ],
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 1,
                                  ),
                                  boxShadow: [
                                    BoxShadow(color: Colors.blue, blurRadius: 3)
                                  ],
                                  borderRadius: BorderRadius.circular(12),
                                )),
                          );
                        }).toList(),
                      );
                    }
                }
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute<void>(builder: (BuildContext context) {
            return WriteScript(uid: widget.uid);
          }));
        },
        tooltip: '스크립트를 추가하려면 클릭하세요',
        label: Text("스크립트 추가"),
        icon: Icon(Icons.add),
        backgroundColor: Colors.red[200],
      ),
    );
  }

//  void showDocument(String documentID) {
//    Firestore.instance.collection(widget.uid).document(documentID).get();
//  }

  void deleteScript(String docID) {
    Firestore.instance
        .collection(widget.uid + '_script')
        .document(docID)
        .delete();
  }

  void showAlertDialog(docID) async {
    await showDialog(
      context: _context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('삭제 경고'),
          content: Text("정말 삭제하시겠습니까?\n삭제된 스크립트는 복구되지 않습니다."),
          actions: <Widget>[
            FlatButton(
              child: Text('삭제'),
              onPressed: () {
                deleteScript(docID);
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
