import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/app/data/model/radiomodel.dart';
import 'package:thekingcoffee/app/screens/favorite_page.dart';

import 'package:thekingcoffee/app/screens/helper/dashboard_helper/placeholder_home.dart';
import 'package:thekingcoffee/app/screens/setting.dart';
import 'package:thekingcoffee/app/screens/shopping_list.dart';
import 'package:thekingcoffee/core/components/lib/change_language/localizations.dart';

class DashBoard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<DashBoard> {
  List<RadioModel> _langList = new List<RadioModel>();
  int _index = 0;
  final List<Widget> _children = [
    PlaceholderMainWidget(),
    Favorite_Page(),
    Shopping_List(),
    Setting(),
  ];
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    // _initLanguage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.redAccent),
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          body: _children[Config.current_botton_tab],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            onTap: onTabTapped,
            currentIndex: Config.current_botton_tab,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text("Home"),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border),
                title: Text("Favorite"),
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  title: Text("Shopping List")),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), title: Text("Setting")),
            ],
          ),
        ));
  }

  void onTabTapped(int index) {
    setState(() {
      Config.current_botton_tab = index;
    });
  }

  Future<String> _getLanguageCode() async {
    var prefs = await SharedPreferences.getInstance();
    if (prefs.getString('languageCode') == null) {
      return null;
    }
    print('_fetchLocale():' + prefs.getString('languageCode'));
    return prefs.getString('languageCode');
  }

  void _initLanguage() async {
    Future<String> status = _getLanguageCode();
    status.then((result) {
      if (result != null && result.compareTo('en') == 0) {
        setState(() {
          _index = 0;
        });
      }
      if (result != null && result.compareTo('vi') == 0) {
        setState(() {
          _index = 1;
        });
      } else {
        setState(() {
          _index = 0;
        });
      }

      _setupLangList();
    });
  }

  void _setupLangList() {
    setState(() {
      _langList.add(new RadioModel(_index == 0 ? true : false, 'English'));
      _langList.add(new RadioModel(_index == 0 ? false : true, 'VN'));
    });
  }
}
