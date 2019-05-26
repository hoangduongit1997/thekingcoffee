import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/app/screens/favorite_page.dart';

import 'package:thekingcoffee/app/screens/helper/dashboard_helper/placeholder_home.dart';
import 'package:thekingcoffee/app/screens/setting.dart';
import 'package:thekingcoffee/app/screens/shopping_list.dart';

class DashBoard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<DashBoard> {
  final List<Widget> _children = [
    PlaceholderMainWidget(),
    Favorite_Page(),
    Shopping_List(),
    Setting(),
  ];
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    Config.isHideNavigation = false;
    super.initState();
  }

  @override
  void dispose() {
    this.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.redAccent),
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: _children[Config.current_botton_tab],
          bottomNavigationBar: Config.isHideNavigation == true
              ? null
              : BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  onTap: onTabTapped,
                  currentIndex: Config.current_botton_tab,
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
                        icon: Icon(Icons.shopping_cart),
                        title: Text('Shopping List')),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.settings), title: Text('Setting')),
                  ],
                ),
        ));
  }

  void onTabTapped(int index) {
    setState(() {
      Config.current_botton_tab = index;
    });
  }
}
