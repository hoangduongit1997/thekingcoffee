import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:thekingcoffee/app/bloc/bottom_navigation_bloc.dart';

import 'package:thekingcoffee/app/screens/favorite_page.dart';

import 'package:thekingcoffee/app/screens/helper/dashboard_helper/placeholder_home.dart';
import 'package:thekingcoffee/app/screens/setting.dart';
import 'package:thekingcoffee/app/screens/shopping_list.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:thekingcoffee/core/components/lib/change_language/change_language.dart';

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
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: StreamBuilder<NavBarItem>(
            stream: _bottomNavBarBloc.itemStream,
            initialData: _bottomNavBarBloc.defaultItem,
            builder:
                (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
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
            builder:
                (BuildContext context, AsyncSnapshot<NavBarItem> snapshot) {
              return BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                fixedColor: Colors.redAccent,
                currentIndex: snapshot.data.index,
                onTap: _bottomNavBarBloc.pickItem,
                items: [
                  BottomNavigationBarItem(
                    title: Text(
                      allTranslations.text("home_page").toString(),
                    ),
                    icon: Icon(Icons.home),
                  ),
                  BottomNavigationBarItem(
                    title: Text(allTranslations.text("favorite").toString()),
                    icon: Icon(Icons.favorite_border),
                  ),
                  BottomNavigationBarItem(
                    title:
                        Text(allTranslations.text("shopping_list").toString()),
                    icon: Icon(Icons.shopping_cart),
                  ),
                  BottomNavigationBarItem(
                    title: Text(allTranslations.text("setting").toString()),
                    icon: Icon(Icons.settings),
                  ),
                ],
              );
            },
          ),
        ));
  }
}
