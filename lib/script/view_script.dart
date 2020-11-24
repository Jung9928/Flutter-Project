import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/script/edit_script.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ViewPage extends StatefulWidget {
  ViewPage({Key key, this.title, this.text, this.date, this.docID, this.uid})
      : super(key: key);

  final String title;
  final String text;
  final String date;
  final String docID;
  final String uid;

  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[200],
          title: Text(
            '스크립트 내용',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: showAlertDialog,
            ),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditPage(
                              title: widget.title,
                              text: widget.text,
                              date: widget.date,
                              docID: widget.docID,
                              uid: widget.uid,
                            )));
              },
            )
          ],
        ),
        body: Padding(padding: EdgeInsets.all(20), child: loadBuilder()));
  }

//  Future<List<ScriptPage>> loadMemo(String id) async {
//    DBHelper sd = DBHelper();
//    return await sd.findMemo(id);
//  }

  loadBuilder() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection(widget.uid + "_script").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return Text("Error: ${snapshot.error}");
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Text("Loading...");
          default:
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: 70,
                  child: SingleChildScrollView(
                    child: Text(
                      widget.title.toString(),
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Text(
                  "스크립트 만든 시간: " + widget.date.split('.')[0],
                  style: TextStyle(fontSize: 11),
                  textAlign: TextAlign.end,
                ),
                Text(
                  "스크립트 수정 시간: " + widget.date.split('.')[0],
                  style: TextStyle(fontSize: 11),
                  textAlign: TextAlign.end,
                ),
                Padding(padding: EdgeInsets.all(10)),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(widget.text),
                  ),
                )
              ],
            );
        }
      },
    );
  }

  void showAlertDialog() async {
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
                deleteScript(widget.docID);
                flutterToast();
                Navigator.pop(context, "삭제");
                Navigator.pop(_context);
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

  // 스크립트 삭제 완료 여부를 알려주는 토스트 메시지
  void flutterToast() {
    Fluttertoast.showToast(
      msg: '스크립트 삭제 완료',
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red[200],
      fontSize: 20.0,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
    );
  }

  void deleteScript(String docID) {
    Firestore.instance
        .collection(widget.uid + '_script')
        .document(docID)
        .delete();
  }
}
