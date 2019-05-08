import 'package:flutter/material.dart';
import 'package:thekingcoffee/app/screens/helper/dashboard_helper/placeholder.dart';
import 'package:thekingcoffee/app/screens/helper/dashboard_helper/placeholder_home.dart';

class DashBoard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<DashBoard> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    PlaceholderMainWidget(),
    PlaceholderWidget(Colors.white),
    PlaceholderWidget(Colors.green),
    PlaceholderWidget(Colors.black),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.redAccent),
        home: Scaffold(
          body: _children[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: onTabTapped,
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                title: Text('Favorites'),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.today), title: Text('Shopping List')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), title: Text('More')),
            ],
          ),
        ));
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
