import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:thekingcoffee/app/config/config.dart';
import 'package:thekingcoffee/app/screens/dashboard.dart';
import 'package:thekingcoffee/app/screens/helper/dashboard_helper/placeholder_home.dart';
import 'package:thekingcoffee/app/screens/login.dart';
import 'package:thekingcoffee/app/screens/shopping_list.dart';
import 'package:thekingcoffee/app/styles/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeMenu extends StatefulWidget {
  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        new UserAccountsDrawerHeader(
          accountName: Text(
            'Hoàng Dương',
            style: StylesText.style15BlackBold,
          ),
          accountEmail: Text(
            'hoangduongit1997@gmail.com',
            style: StylesText.style13Black,
          ),
          currentAccountPicture: GestureDetector(
              child: Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      Config.ip + "/storage/images/kingcoffee/congan.png",
                    ))),
          )),
          decoration: new BoxDecoration(color: Colors.redAccent),
        ),
        InkWell(
          onTap: () {},
          child: ListTile(
            title: Text(
              'Home',
              style: StylesText.style13BlackBold,
            ),
            leading: Icon(Icons.home, color: Colors.redAccent),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => PlaceholderMainWidget()));
            },
          ),
        ),
        InkWell(
          onTap: () {},
          child: ListTile(
            title: Text(
              'My account',
              style: StylesText.style13BlackBold,
            ),
            leading: Icon(
              Icons.person,
              color: Colors.redAccent,
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          child: ListTile(
            title: Text(
              'Favourites',
              style: StylesText.style13BlackBold,
            ),
            leading: Icon(Icons.favorite, color: Colors.redAccent),
          ),
        ),
        InkWell(
          onTap: () {},
          child: ListTile(
            title: Text(
              'Shopping List',
              style: StylesText.style13BlackBold,
            ),
            leading: Icon(Icons.shopping_cart, color: Colors.redAccent),
            onTap: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Shopping_List()));
            },
          ),
        ),
        InkWell(
          onTap: () {},
          child: ListTile(
            title: Text(
              'History',
              style: StylesText.style13BlackBold,
            ),
            leading: Icon(Icons.history, color: Colors.redAccent),
          ),
        ),
        InkWell(
          onTap: () {},
          child: ListTile(
            title: Text(
              'Log out',
              style: StylesText.style13BlackBold,
            ),
            leading: Icon(Icons.error, color: Colors.redAccent),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
                      title: new Text("Confirm",
                          style: StylesText.style18RedaccentBold),
                      content: new Text(
                        "Do you want to exit ?",
                        style: StylesText.style15Black,
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("No"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        FlatButton(
                          child: Text("Yes"),
                          onPressed: () async {
                            SharedPreferences preferences =
                                await SharedPreferences.getInstance();
                            preferences.clear();
                            print(preferences);
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => LoginWithPass()));
                          },
                        ),
                      ],
                    );
                  });
            },
          ),
        ),
      ],
    );
  }
}
