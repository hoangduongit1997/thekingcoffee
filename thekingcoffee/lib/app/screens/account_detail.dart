import 'package:flutter/material.dart';
class Account extends StatefulWidget {
  Account({Key key}) : super(key: key);

  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("A"),),
      
    );
  }
}