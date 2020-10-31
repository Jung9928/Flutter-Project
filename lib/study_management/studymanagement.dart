import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Management extends StatefulWidget {
  Management({
    Key key,
    this.saveHouseNoviceCount,
    this.saveHouseImCount,
    this.saveHouseAlCount,
    this.houseNoviceFullCount,
    this.houseImFullCount,
    this.houseAlFullCount,
  }) : super(key: key);

  int saveHouseNoviceCount;
  int saveHouseImCount;
  int saveHouseAlCount;
  int houseNoviceFullCount;
  int houseImFullCount;
  int houseAlFullCount;

  @override
  _ManagementState createState() => _ManagementState();
}

class _ManagementState extends State<Management> {
  double percentNovice = 0;
  double percentIm = 0;
  double percentAl = 0;
//  int saveNoviceCount = 0; // 최근에 몇번 째 novice level 영어문장을 읽었는지 저장
//  int noviceFullCount = 0; // novice level의 영어문장 총 갯수

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    widget.saveHouseNoviceCount =
        int.parse(widget.saveHouseNoviceCount.toString());
    widget.houseNoviceFullCount =
        int.parse(widget.houseNoviceFullCount.toString());
    percentNovice = widget.saveHouseNoviceCount / widget.houseNoviceFullCount;

    widget.saveHouseImCount = int.parse(widget.saveHouseImCount.toString());
    widget.houseImFullCount = int.parse(widget.houseImFullCount.toString());
    percentIm = widget.saveHouseImCount / widget.houseImFullCount;

    widget.saveHouseAlCount = int.parse(widget.saveHouseAlCount.toString());
    widget.houseAlFullCount = int.parse(widget.houseAlFullCount.toString());
    percentAl = widget.saveHouseAlCount / widget.houseAlFullCount;

    // 값 확인 차 넣은 print문
    print('percent : ' + percentNovice.toString());
    print('saveNoviceCount : ' + widget.saveHouseNoviceCount.toString());
    print('novicefullCount : ' + widget.houseNoviceFullCount.toString());

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
              stream: Firestore.instance
                  .collection("save_house_novice_index")
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
                    return ListView(children: <Widget>[
                      SizedBox(height: width * 0.1),
                      CircularPercentIndicator(
                        radius: 120.0,
                        lineWidth: 13.0,
                        animation: true,
                        percent: percentNovice,
                        center: new Text(
                          (percentNovice * 100).toString() + '%',
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
                          (percentIm * 100).toString() + '%',
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
                          (percentAl * 100).toString() + '%',
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
}
