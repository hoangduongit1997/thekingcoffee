import 'package:flutter/material.dart';
import 'package:thekingcoffee/app/screens/favorite_page.dart';
import 'package:thekingcoffee/app/screens/helper/dashboard_helper/placeholder.dart';
import 'package:thekingcoffee/app/screens/helper/dashboard_helper/placeholder_home.dart';
import 'package:thekingcoffee/app/screens/shopping_list.dart';

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
    Favorite_Page(),
    Shopping_List (),
    PlaceholderWidget(Colors.black),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.redAccent),
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: _children[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            
            key: Key(_children[_currentIndex].toString()),
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
                  icon: Icon(Icons.shopping_cart), title: Text('Shopping List')),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), title: Text('Setting')),
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
