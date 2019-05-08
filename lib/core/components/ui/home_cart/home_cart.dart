import 'package:flutter/material.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/components/widgets/drawline.dart';
import 'package:thekingcoffee/core/components/widgets/favorite.dart';
import 'package:thekingcoffee/core/components/widgets/rating.dart';
import 'package:thekingcoffee/core/utils/utils.dart';

class Home_Card extends StatelessWidget {
  final List<String> titles = ['Homes', 'Experiences', 'Adventure', 'Trips'];

  @override
  Widget build(BuildContext context) {
    return Theme(
      child: buildBottomNavBar(context),
      data: ThemeData(
        primaryColor: Colors.orangeAccent,
      ),
    );
  }

  Scaffold buildBottomNavBar(context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: 280,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: 4,
                      itemBuilder: (BuildContext context, int index) {
                        return _buildItems(index, context);
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildItems(int index, context) {
    final int imgIndex = index + 1;
    return new Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey[300]),
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        margin: EdgeInsets.only(right: 12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Container(
                        height: Dimension.getHeight(0.18),
                        width: Dimension.getWidth(0.51),
                        decoration: new BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: new Border.all(color: Colors.grey),
                            image: new DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    'assets/images/img$imgIndex.jpg'))),
                      ),
                    ),
                    Favorite(
                      color: Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Container(
                  width: Dimension.getWidth(0.51),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        titles[index],
                        style: StylesText.style17BrownBold,
                      ),
                    ],
                  ),
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Row(
                children: <Widget>[
                  StarRating(
                    size: 13.0,
                    rating: 3.0,
                    color: Colors.orange,
                    borderColor: Colors.grey,
                    starCount: 5,
                  ),
                  Text("107", style: StylesText.style13BrownNormal)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(5, 10, 50, 0),
              child: Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  CustomPaint(painter: Drawhorizontalline(false)),
                ],
              )),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Row(
                children: <Widget>[
                  Text("recipe by ", style: StylesText.style11BrownNormal),
                  Text("Master Chef", style: StylesText.style13BrownBold)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Container(
                width: Dimension.getWidth(0.51),
                child: Row(
                  children: <Widget>[
                    Stack(
                      alignment: AlignmentDirectional.centerStart,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.access_alarms,
                              color: Colors.redAccent,
                            ),
                            Text(
                              "1h30p",
                              style: StylesText.style12Brown300,
                            )
                          ],
                        ),
                        Container(
                          width: Dimension.getWidth(0.51),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Icon(
                                Icons.fastfood,
                                color: Colors.redAccent,
                              ),
                              Text(
                                "4 servings",
                                style: StylesText.style12Brown300,
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
