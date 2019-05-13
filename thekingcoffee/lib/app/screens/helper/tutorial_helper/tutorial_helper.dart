import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:thekingcoffee/app/data/repository/fake_data_intro.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/utils/utils.dart';

void main() => runApp(CarouselDemo());

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
  final List child = map<Widget>(
    intro_slide,
    (index, i) {
      return Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Stack(children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    child: Container(
                      width: Dimension.getWidth(0.66),
                      height: Dimension.getHeight(0.56),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey[100],
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15.0),
                                      topRight: Radius.circular(15.0)),
                                ),
                                width: double.infinity,
                                height: Dimension.getHeight(0.18),
                              )),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                              child: Text(
                                intro_slide[index].titles.toString(),
                                style: StylesText.style20BrownBold,
                              )),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                              child: Center(
                                  child: Text(
                                intro_slide[index].subtitles.toString(),
                                style: StylesText.style12Brown300,
                              ))),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Center(
                              child: Image.asset(
                                intro_slide[0].icons,
                                width: Dimension.getWidth(0.15),
                                height: Dimension.getHeight(0.15),
                              ),
                            ),
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ]),
        ],
      ));
    },
  ).toList();
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
        items: child,
        height: Dimension.getHeight(0.6),
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
          intro_slide,
          (index, url) {
            return Container(
              width: Dimension.getWidth(0.015),
              height: Dimension.getWidth(0.015),
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      _current == index ? Colors.redAccent : Colors.red[100]),
            );
          },
        ),
      ),
    ]);
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