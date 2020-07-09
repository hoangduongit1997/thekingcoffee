import 'dart:async';
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
        numberBloc.checkNumber();
        _navBarController.sink.add(NavBarItem.HOME);
        break;
      case 1:
        numberBloc.checkNumber();
        _navBarController.sink.add(NavBarItem.FAVORITE);
        break;
      case 2:
        numberBloc.checkNumber();
        _navBarController.sink.add(NavBarItem.SHOPPING_LIST);
        break;
      case 3:
        numberBloc.checkNumber();
        _navBarController.sink.add(NavBarItem.SETTING);
        break;
    }
  }

  close() {
    _navBarController?.close();
  }
}
