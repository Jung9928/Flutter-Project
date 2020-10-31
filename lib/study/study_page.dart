import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_login/level_check/bank_level_check.dart';
import 'package:flutter_firebase_login/level_check/house_level_check.dart';

class StudyPage extends StatefulWidget {
  @override
  _StudyPageState createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> {
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[200],
        title: Text(
          'OPIc에 유용한 문장 모음',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            child: CustomPaint(
              painter: ShapesPainter(),
              child: Container(
                height: size.height / 2,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 40),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: GridView.count(
                crossAxisCount: 2,
                children: <Widget>[
                  createGridItem(0, '집'),
                  createGridItem(1, '은행'),
                  createGridItem(2, '외식/음식'),
                  createGridItem(3, '산업'),
                  createGridItem(4, '기술'),
                  createGridItem(5, '교통수단'),
                  createGridItem(6, '날씨/계절'),
                  createGridItem(7, '명절'),
                  createGridItem(8, '가구/가전'),
                  createGridItem(9, '약속'),
                  createGridItem(10, '재활용'),
                  createGridItem(11, '패션'),
                  createGridItem(12, '전화통화'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget createGridItem(int position, String name) {
    var color = Colors.white;
    var icondata = Icons.add;

    switch (position) {
      case 0:
        color = Colors.red[200];
        icondata = Icons.home;
        return GestureDetector(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10.0, right: 10, bottom: 5, top: 5),
            child: Card(
              elevation: 10,
              color: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                side: BorderSide(color: Colors.white),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                    return LevelCheck();
                  }));
                },
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        icondata,
                        size: 80,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          name,
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      case 1:
        color = Colors.deepPurple;
        icondata = Icons.monetization_on;
        return GestureDetector(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10.0, right: 10, bottom: 5, top: 5),
            child: Card(
              elevation: 10,
              color: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                side: BorderSide(color: Colors.white),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                    return BankLevelCheck();
                  }));
                },
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        icondata,
                        size: 80,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          name,
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      case 2:
        color = Colors.orange[300];
        icondata = Icons.restaurant;
        return GestureDetector(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10.0, right: 10, bottom: 5, top: 5),
            child: Card(
              elevation: 10,
              color: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                side: BorderSide(color: Colors.white),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                    return LevelCheck();
                  }));
                },
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        icondata,
                        size: 80,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          name,
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      case 3:
        color = Colors.pinkAccent;
        icondata = Icons.wb_incandescent;
        return GestureDetector(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10.0, right: 10, bottom: 5, top: 5),
            child: Card(
              elevation: 10,
              color: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                side: BorderSide(color: Colors.white),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                    return LevelCheck();
                  }));
                },
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        icondata,
                        size: 80,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          name,
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      case 4:
        color = Colors.teal[900];
        icondata = Icons.router;
        return GestureDetector(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10.0, right: 10, bottom: 5, top: 5),
            child: Card(
              elevation: 10,
              color: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                side: BorderSide(color: Colors.white),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                    return LevelCheck();
                  }));
                },
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        icondata,
                        size: 80,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          name,
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      case 5:
        color = Colors.brown[600];
        icondata = Icons.directions_transit;
        return GestureDetector(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10.0, right: 10, bottom: 5, top: 5),
            child: Card(
              elevation: 10,
              color: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                side: BorderSide(color: Colors.white),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                    return LevelCheck();
                  }));
                },
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        icondata,
                        size: 80,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          name,
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      case 6:
        color = Colors.blueAccent;
        icondata = Icons.wb_sunny;
        return GestureDetector(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10.0, right: 10, bottom: 5, top: 5),
            child: Card(
              elevation: 10,
              color: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                side: BorderSide(color: Colors.white),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                    return LevelCheck();
                  }));
                },
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        icondata,
                        size: 80,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          name,
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      case 7:
        color = Colors.redAccent;
        icondata = Icons.people_outline;
        return GestureDetector(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10.0, right: 10, bottom: 5, top: 5),
            child: Card(
              elevation: 10,
              color: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                side: BorderSide(color: Colors.white),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                    return LevelCheck();
                  }));
                },
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        icondata,
                        size: 80,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          name,
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      case 8:
        color = Colors.black38;
        icondata = Icons.weekend;
        return GestureDetector(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10.0, right: 10, bottom: 5, top: 5),
            child: Card(
              elevation: 10,
              color: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                side: BorderSide(color: Colors.white),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                    return LevelCheck();
                  }));
                },
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        icondata,
                        size: 80,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          name,
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      case 9:
        color = Colors.deepPurpleAccent;
        icondata = Icons.people;
        return GestureDetector(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10.0, right: 10, bottom: 5, top: 5),
            child: Card(
              elevation: 10,
              color: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                side: BorderSide(color: Colors.white),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                    return LevelCheck();
                  }));
                },
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        icondata,
                        size: 80,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          name,
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      case 10:
        color = Colors.deepOrangeAccent;
        icondata = Icons.restore_from_trash;
        return GestureDetector(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10.0, right: 10, bottom: 5, top: 5),
            child: Card(
              elevation: 10,
              color: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                side: BorderSide(color: Colors.white),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                    return LevelCheck();
                  }));
                },
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        icondata,
                        size: 80,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          name,
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      case 11:
        color = Colors.lime;
        icondata = Icons.accessibility;
        return GestureDetector(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10.0, right: 10, bottom: 5, top: 5),
            child: Card(
              elevation: 10,
              color: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                side: BorderSide(color: Colors.white),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                    return LevelCheck();
                  }));
                },
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        icondata,
                        size: 80,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          name,
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      case 12:
        color = Colors.green[600];
        icondata = Icons.call;
        return GestureDetector(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 10.0, right: 10, bottom: 5, top: 5),
            child: Card(
              elevation: 10,
              color: color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                side: BorderSide(color: Colors.white),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute<void>(builder: (BuildContext context) {
                    return LevelCheck();
                  }));
                },
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        icondata,
                        size: 80,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          name,
                          style: TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
    }
  }
}

class ShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    paint.color = Colors.greenAccent[100];
    canvas.drawCircle(
        Offset(size.width * 0.5, size.height * 0.2), size.height * 0.7, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
