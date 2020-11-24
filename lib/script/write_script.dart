import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// 컬렉션 명
//String colName = 'script';

// 필드명
String scriptName = '';
String scriptContent = '';
String scriptDate = '';

class WriteScript extends StatefulWidget {
  WriteScript({this.uid});

  final String uid; // 로그인한 사용자의 firebase uid 값.

  @override
  _WriteScriptState createState() => _WriteScriptState();
}

class _WriteScriptState extends State<WriteScript> {
  // 필드 명

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[200],
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              createScript(scriptName, scriptContent);
              save_toast();
//              Scaffold.of(context)
//                  .showSnackBar(SnackBar(content: Text('스크립트가 저장되었습니다.')));
            },
          )
        ],
        title: Text(
          '스크립트 추가',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            TextField(
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              keyboardType: TextInputType.multiline,
              maxLines: null, // 최대 줄을 null로 설정하여 입력에 제한이 없도록 함.
              decoration: InputDecoration(
                hintText: '스크립트 제목을 적어 주세요.',
              ),
              onChanged: (String name) {
                setState(() {
                  scriptName = name;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            TextField(
                decoration: InputDecoration(
                  hintText: '스크립트 내용을 적어 주세요.',
                ),
                onChanged: (String text) {
                  setState(() {
                    scriptContent = text;
                  });
                })
          ],
        ),
      ),
    );
  }

  // 스크립트 생성 시, firestore에 생성한 스크립트 데이터 저장.
  void createScript(String name, String description) {
    Firestore.instance.collection(widget.uid + '_script').add({
      'scriptTitle': name,
      'scriptText': description,
      'scriptDate': Timestamp.now(),
    });
  }

  // 스크립트 저장 완료를 알려주는 토스트 메시지
  void save_toast() {
    Fluttertoast.showToast(
      msg: '스크립트 저장 완료',
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.red[200],
      fontSize: 20.0,
      textColor: Colors.white,
      toastLength: Toast.LENGTH_SHORT,
    );
  }
}
