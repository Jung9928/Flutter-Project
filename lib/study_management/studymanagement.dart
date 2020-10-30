import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Management extends StatefulWidget {
  @override
  _ManagementState createState() => _ManagementState();
}

class _ManagementState extends State<Management> {
  BuildContext _context;
  double percent = 0;
  int saveNoviceCount = 0; // 최근에 몇번 째 novice level 영어문장을 읽었는지 저장
  int novicefullCount = 0; // novice level의 영어문장 총 갯수

  @override
  Widget build(BuildContext context) {
    _context = context;
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    saveNoviceCount = int.parse(saveNoviceCount.toString());
    novicefullCount = int.parse(novicefullCount.toString());
    percent = saveNoviceCount / novicefullCount;

    // 값 확인 차 넣은 print문
    print(percent);
    print(saveNoviceCount);
    print(novicefullCount);

    getSaveData();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[200],
          title: Text(
            '학습 관리',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Center(
          child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection("save").snapshots(),
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
                    return ListView(children: <Widget>[
                      SizedBox(height: width * 0.1),
                      CircularPercentIndicator(
                        radius: 120.0,
                        lineWidth: 13.0,
                        animation: true,
                        percent: percent,
                        center: new Text(
                          (percent * 100).toString() + '%',
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        footer: new Text(
                          "NL~NH 문장 학습 진행률",
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17.0),
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Colors.green,
                      ),
                      SizedBox(height: width * 0.1),
                      CircularPercentIndicator(
                        radius: 120.0,
                        lineWidth: 13.0,
                        animation: true,
                        percent: 0.7,
                        center: new Text(
                          "70.0%",
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        footer: new Text(
                          "IL~IM 문장 학습 진행률",
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17.0),
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Colors.purple,
                      ),
                      SizedBox(height: width * 0.1),
                      CircularPercentIndicator(
                        radius: 120.0,
                        lineWidth: 13.0,
                        animation: true,
                        percent: 0.7,
                        center: new Text(
                          "70.0%",
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                        ),
                        footer: new Text(
                          "AL 문장 학습 진행률",
                          style: new TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17.0),
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Colors.orange,
                      ),
                      SizedBox(height: width * 0.1),
                    ]);
                }
              }),
        ),
      ),
    );
  }

  // "집안일 거들기"에서 novice 레벨의 document들 갯수를 count하는 함수.
  Future<void> countNovice() async {
    QuerySnapshot _myDoc =
        await Firestore.instance.collection('house_novice').getDocuments();
    List<DocumentSnapshot> _myDocCount = _myDoc.documents;
    novicefullCount = _myDocCount.length;
  }

  // firestore에서 최근에 봤던 영어 문장의 index가 저장된 데이터를 읽어옴.
  Future<void> getSaveData() async {
    countNovice();
    await Firestore.instance
        .collection('save')
        .document('index')
        .get()
        .then((idx) {
      saveNoviceCount = idx.data['textIndex'];
    });
  }

//  Future<void> showAlertRetrievedDataDialog() async {
//    countNovice();
//    await showDialog(
//      context: _context,
//      barrierDismissible: false, // 선택지 외의 공간을 눌렀을 때, 반응 안하도록 설정
//      builder: (BuildContext context) {
//        return AlertDialog(
//          title: Text('학습 진행률 데이터 갱신 알림'),
//          content: Text("확인을 누르시면 최근 데이터를 반영하여 \n학습 진행률이 갱신됩니다."),
//          actions: <Widget>[
//            FlatButton(
//              child: Text('확인'),
//              onPressed: () {
//                Navigator.pop(context, getSaveData());
//              },
//            ),
//          ],
//        );
//      },
//    );
//  }
}
