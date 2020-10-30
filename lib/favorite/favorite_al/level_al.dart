import 'package:flutter/material.dart';

class LevelAl extends StatefulWidget {
  @override
  _LevelAlState createState() => _LevelAlState();
}

class _LevelAlState extends State<LevelAl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[200],
        title: Text(
          '모두의 오픽',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(),
    );
  }
}
