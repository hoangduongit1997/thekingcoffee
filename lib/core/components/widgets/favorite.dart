import 'package:flutter/material.dart';

class Favorite extends StatefulWidget {
  final Color color;
  Favorite({this.color = Colors.blueGrey});

  @override
  _HeartState createState() => _HeartState();
}

class _HeartState extends State<Favorite> {
  bool isClick = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isClick = !isClick;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(500.0)),
          color: isClick == true
              ? Color.fromRGBO(255, 23, 68, 1.0)
              : Color.fromRGBO(0, 0, 0, 0.0),
        ),
        child: Padding(
          padding: EdgeInsets.all(0.0),
          child: Icon(
            Icons.favorite_border,
            color: isClick == true ? Colors.white : this.widget.color,
          ),
        ),
      ),
    );
  }
}
