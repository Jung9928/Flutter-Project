import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Household_Intermediate extends StatefulWidget {
  @override
  _Household_IntermediateState createState() => _Household_IntermediateState();
}

class _Household_IntermediateState extends State<Household_Intermediate> {
  int _QuestionCount = 0; // 영어 문장 인덱스&firestore에서 저장된 영어문장을 읽어올 때 사용되는 인덱스.
  int _fullCount = 10;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red[200],
          title: Text(
            '집안일 거들기',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Stack(
          children: [
            BackgroundImage(context),
            Center(
              child: StreamBuilder<QuerySnapshot>(
                stream: Firestore.instance
                    .collection("house_intermediate")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError)
                    return Text("Error: ${snapshot.error}");
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Text("Loading...");
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
                                  (_QuestionCount + 1).toString() +
                                      ' / ' +
                                      _fullCount.toString(),
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
                                          .documents[_QuestionCount]['text']
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
                                        .documents[_QuestionCount]
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
                            Container(
                              padding: EdgeInsets.only(bottom: width * 0.048),
                              child: ButtonTheme(
                                minWidth: width * 0.73,
                                height: height * 0.05,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: RaisedButton(
                                  onPressed: () {
                                    setState(() {
                                      _QuestionCount++;
                                    });
                                  },
                                  child: Text(
                                    '다음 문장 보기',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  color: Colors.white,
                                  textColor: Colors.black,
                                ),
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
