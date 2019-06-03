import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:thekingcoffee/app/bloc/bottom_navigation_bloc.dart';

import 'package:thekingcoffee/app/screens/favorite_page.dart';

import 'package:thekingcoffee/app/screens/helper/dashboard_helper/placeholder_home.dart';
import 'package:thekingcoffee/app/screens/setting.dart';
import 'package:thekingcoffee/app/screens/shopping_list.dart';
import 'package:thekingcoffee/app/styles/styles.dart';

class DashBoard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<DashBoard> {
  BottomNavBarBloc _bottomNavBarBloc;
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);

    _bottomNavBarBloc = new BottomNavBarBloc();
    super.initState();
  }

  @override
  void dispose() {
    _bottomNavBarBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.redAccent),
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: StreamBuilder<NavBarItem>(
          stream: _bottomNavBarBloc.itemStream,
          initialData: _bottomNavBarBloc.defaultItem,
          builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
            switch (snapshot.data) {
              case NavBarItem.HOME:
                return PlaceholderMainWidget();
              case NavBarItem.FAVORITE:
                return Favorite_Page();
              case NavBarItem.SHOPPING_LIST:
                return Shopping_List();
              case NavBarItem.SETTING:
                return Setting();
            }
          },
        ),
        bottomNavigationBar: StreamBuilder(
          stream: _bottomNavBarBloc.itemStream,
          initialData: _bottomNavBarBloc.defaultItem,
          builder: (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              fixedColor: Colors.redAccent,
              currentIndex: snapshot.data.index,
              onTap: _bottomNavBarBloc.pickItem,
              items: [
                BottomNavigationBarItem(
                  title: Text(
                    "Home",
                  ),
                  icon: Icon(Icons.home),
                ),
                BottomNavigationBarItem(
                  title: Text('Favorite'),
                  icon: Icon(Icons.favorite_border),
                ),
                BottomNavigationBarItem(
                  title: Text('Shopping List'),
                  icon: Icon(Icons.shopping_cart),
                ),
                BottomNavigationBarItem(
                  title: Text('Settings'),
                  icon: Icon(Icons.settings),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Future<String> _getLanguageCode() async {
  //   var prefs = await SharedPreferences.getInstance();
  //   if (prefs.getString('languageCode') == null) {
  //     return null;
  //   }
  //   print('_fetchLocale():' + prefs.getString('languageCode'));
  //   return prefs.getString('languageCode');
  // }

  // void _initLanguage() async {
  //   Future<String> status = _getLanguageCode();
  //   status.then((result) {
  //     if (result != null && result.compareTo('en') == 0) {
  //       setState(() {
  //         _index = 0;
  //       });
  //     }
  //     if (result != null && result.compareTo('vi') == 0) {
  //       setState(() {
  //         _index = 1;
  //       });
  //     } else {
  //       setState(() {
  //         _index = 0;
  //       });
  //     }

  //     _setupLangList();
  //   });
  // }

  // void _setupLangList() {
  //   setState(() {
  //     _langList.add(new RadioModel(_index == 0 ? true : false, 'English'));
  //     _langList.add(new RadioModel(_index == 0 ? false : true, 'VN'));
  //   });
  // }
}
