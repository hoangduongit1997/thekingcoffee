import 'dart:async';

enum NavBarItem { HOME, FAVORITE, SHOPPING_LIST, SETTING }

class BottomNavBarBloc {
  final StreamController<NavBarItem> _navBarController =
      StreamController<NavBarItem>.broadcast();

  NavBarItem defaultItem = NavBarItem.HOME;

  Stream<NavBarItem> get itemStream => _navBarController.stream;

  void pickItem(int i) {
    switch (i) {
      case 0:
        _navBarController.sink.add(NavBarItem.HOME);
        break;
      case 1:
        _navBarController.sink.add(NavBarItem.FAVORITE);
        break;
      case 2:
        _navBarController.sink.add(NavBarItem.SHOPPING_LIST);
        break;
      case 3:
        _navBarController.sink.add(NavBarItem.SETTING);
        break;
    }
  }

  close() {
    _navBarController?.close();
  }
}
