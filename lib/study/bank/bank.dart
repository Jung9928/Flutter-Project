import 'package:flutter/material.dart';

class Bank extends StatefulWidget {
  @override
  _BankState createState() => _BankState();
}

class _BankState extends State<Bank> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[200],
        title: Text(
          '은행',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
    ;
  }
}
