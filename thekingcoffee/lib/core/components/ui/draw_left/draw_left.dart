import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
          accountName: Text('Santos Enoque'),
          accountEmail: Text('santosenoque.ss@gmail.com'),
          currentAccountPicture: GestureDetector(
            child: new CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
          ),
          decoration: new BoxDecoration(color: Colors.red),
        ),
        InkWell(
          onTap: () {},
          child: ListTile(
            title: Text('Home Page'),
            leading: Icon(Icons.home),
          ),
        ),
        InkWell(
          onTap: () {},
          child: ListTile(
            title: Text('My account'),
            leading: Icon(Icons.person),
          ),
        ),
        InkWell(
          onTap: () {},
          child: ListTile(
            title: Text('My Orders'),
            leading: Icon(Icons.shopping_basket),
          ),
        ),
        InkWell(
          onTap: () {},
          child: ListTile(
            title: Text('Categoris'),
            leading: Icon(Icons.dashboard),
          ),
        ),
        InkWell(
          onTap: () {},
          child: ListTile(
            title: Text('Favourites'),
            leading: Icon(Icons.favorite),
          ),
        ),
        InkWell(
          onTap: () {},
          child: ListTile(
            title: Text('Settings'),
            leading: Icon(
              Icons.settings,
              color: Colors.blue,
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          child: ListTile(
            title: Text('About'),
            leading: Icon(Icons.help, color: Colors.green),
          ),
        ),
      ],
    );
  }
}
