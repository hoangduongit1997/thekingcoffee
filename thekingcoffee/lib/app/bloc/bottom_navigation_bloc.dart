import 'dart:async';

import 'package:thekingcoffee/app/screens/dashboard.dart';
import 'package:thekingcoffee/main.dart';

enum NavBarItem { HOME, FAVORITE, SHOPPING_LIST, SETTING }

class BottomNavBarBloc {

  StreamController<NavBarItem> _navBarController =
      StreamController<NavBarItem>.broadcast();

  NavBarItem defaultItem = NavBarItem.HOME;
  

  Stream<NavBarItem> get itemStream => _navBarController.stream;
  

  void pickItem(int i) {
    switch (i) {
      case 0:
      number_bloc.Check_Number();
        _navBarController.sink.add(NavBarItem.HOME);
        break;
      case 1:
       number_bloc.Check_Number();
        _navBarController.sink.add(NavBarItem.FAVORITE);
        break;
      case 2:
         number_bloc.Check_Number();
        _navBarController.sink.add(NavBarItem.SHOPPING_LIST);
        break;
      case 3:
       number_bloc.Check_Number();
        _navBarController.sink.add(NavBarItem.SETTING);
        break;
    }
  }

  close() {
    _navBarController?.close();
  }
}
