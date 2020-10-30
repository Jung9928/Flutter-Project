import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/script/write_script.dart';

class EditPage extends StatefulWidget {
  EditPage({Key key, this.title, this.text, this.date, this.docID})
      : super(key: key);

  String title;
  String text;
  String date;
  String docID;

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.red[200],
          title: Text(
            '스크립트 수정하기',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                updateScript(widget.docID, widget.title, widget.text);
              },
            )
          ],
        ),
        body: Padding(padding: EdgeInsets.all(20), child: loadBuilder()));
  }

  loadBuilder() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("test").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) return Text("Error: ${snapshot.error}");
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Text("Loading...");
          default:
            var tecTitle = TextEditingController();
            tecTitle.text = widget.title;

            var tecText = TextEditingController();
            tecText.text = widget.text;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextField(
                  controller: tecTitle,
                  maxLines: 2,
                  onChanged: (String title) {
                    widget.title = tecTitle.text;
                  },
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    hintText: '스크립트의 제목을 적어주세요.',
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                TextField(
                  controller: tecText,
                  maxLines: 8,
                  onChanged: (String text) {
                    widget.text = tecText.text;
                  },
                  decoration: InputDecoration(
                    hintText: '스크립트의 내용을 적어주세요.',
                  ),
                )
              ],
            );
        }
      },
    );
  }

  // 스크립트 수정하기 (firestore 데이터 갱신 / document ID를 모를 경우)
  void updateScript(String docID, String name, String description) {
    Firestore.instance.collection(colName).document(docID).updateData({
      'scriptTitle': name,
      'scriptText': description,
    });
  }
}
