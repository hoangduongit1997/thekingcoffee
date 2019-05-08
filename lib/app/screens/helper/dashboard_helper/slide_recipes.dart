import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:thekingcoffee/app/data/repository/fake_data_home_slider.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/components/widgets/drawline.dart';
import 'package:thekingcoffee/core/components/widgets/rating.dart';
import 'package:thekingcoffee/core/utils/utils.dart';

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class CarouselWithIndicator extends StatefulWidget {
  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;
  static int starCount = 5;
  final List child = map<Widget>(
    home_slider,
    (index, i) {
      return Container(
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          child: Stack(children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Container(
                            height: Dimension.getHeight(0.23),
                            width: Dimension.getWidth(0.45),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: CachedNetworkImage(
                                  imageUrl: home_slider[index].images,
                                  fit: BoxFit.cover,
                                  height: Dimension.getHeight(0.3),
                                  width: Dimension.getWidth(0.5),
                                  placeholder: (context, url) => new SizedBox(
                                        child: Center(
                                            child: CircularProgressIndicator(
                                          valueColor:
                                              new AlwaysStoppedAnimation<Color>(
                                                  Colors.redAccent),
                                        )),
                                      )),
                            )))
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                      child: Center(
                        child: Text(home_slider[index].titles,
                            style: StylesText.style17BrownBold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                      child: Row(
                        children: <Widget>[
                          StarRating(
                            size: 13.0,
                            rating: home_slider[index].stars,
                            color: Colors.orange,
                            borderColor: Colors.grey,
                            starCount: starCount,
                          ),
                          Text(home_slider[index].points.toString(),
                              style: StylesText.style13BrownNormal)
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                        child: Container(
                          child:
                              CustomPaint(painter: Drawhorizontalline(false)),
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 30, 0, 0),
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            foregroundColor: Colors.orange,
                            radius: 12.0,
                          ),
                          Text("  by ", style: StylesText.style11BrownNormal),
                          Text(home_slider[0].names.toString(),
                              style: StylesText.style13BrownBold)
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ]),
        ),
      );
    },
  ).toList();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[300]),
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        CarouselSlider(
          items: child,
          autoPlay: false,
          viewportFraction: 1.0,
          autoPlayInterval: Duration(seconds: 7),
          enlargeCenterPage: false,
          aspectRatio: 2.0,
          onPageChanged: (index) {
            setState(() {
              _current = index;
            });
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: map<Widget>(
            home_slider,
            (index, url) {
              return Container(
                width: Dimension.getWidth(0.01),
                height: Dimension.getHeight(0.008),
                margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 2.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        _current == index ? Colors.redAccent : Colors.red[100]),
              );
            },
          ),
        ),
      ]),
    );
  }
}

class CarouselDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Container(
                child: CarouselWithIndicator(),
              )),
        ),
      ),
    );
  }
}
