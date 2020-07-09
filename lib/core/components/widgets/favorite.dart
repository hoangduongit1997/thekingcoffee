import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:thekingcoffee/app/data/repository/set_loved_respository.dart';
import 'package:thekingcoffee/core/components/lib/change_language/change_language.dart';

class Favorite extends StatefulWidget {
  final Color color;
  bool isLike;
  final int idProduct;
  Favorite(this.color, this.isLike, this.idProduct);

  @override
  _HeartState createState() => _HeartState();
}

class _HeartState extends State<Favorite> {
  bool isClick = false;

  @override
  Widget build(BuildContext context) {
    isClick = widget.isLike;
    return InkWell(
      onTap: () async {
        if (await isLove(widget.idProduct) == 1) {
          setState(() {
            widget.isLike = !widget.isLike;
          });
        } else {
          showToast(
            allTranslations.text("error").toString(),
          );
        }
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
