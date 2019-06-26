import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:thekingcoffee/app/bloc/bottom_navigation_bloc.dart';
import 'package:thekingcoffee/app/bloc/number_bloc.dart';
import 'package:thekingcoffee/app/config/config.dart';

import 'package:thekingcoffee/app/screens/favorite_page.dart';

import 'package:thekingcoffee/app/screens/helper/dashboard_helper/placeholder_home.dart';
import 'package:thekingcoffee/app/screens/setting.dart';
import 'package:thekingcoffee/app/screens/shopping_list.dart';

import 'package:thekingcoffee/core/components/lib/change_language/change_language.dart';
import 'package:thekingcoffee/core/components/ui/home_cart/home_cart_coffee.dart';
import 'package:thekingcoffee/main.dart';

class DashBoard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}



class HomeState extends State<DashBoard> with WidgetsBindingObserver {
  BottomNavBarBloc _bottomNavBarBloc;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _bottomNavBarBloc = new BottomNavBarBloc();
   
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
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
                    icon: Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: <Widget>[
                        Icon(Icons.shopping_cart),
                        Positioned(
                          bottom: 11,
                          child: StreamBuilder<Object>(
                                  initialData: 0,
                              stream: number_bloc.numberStream,
                              builder: (context, snapshot) {
                                return snapshot.data==0?Container(): Container(
                                  decoration: new BoxDecoration(
                                    color: Colors.redAccent,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  constraints: BoxConstraints(
                                    minWidth: 12,
                                    minHeight: 12,
                                  ),
                                  child: Center(
                                      child: Text(
                                    snapshot.data.toString(),
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  )),
                                );
                              }),
                        )
                      ],
                    ),
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
