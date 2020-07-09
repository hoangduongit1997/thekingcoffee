import 'dart:async';

import 'package:thekingcoffee/src/app/core/components/lib/change_language/change_language.dart';
import 'package:thekingcoffee/src/app/core/validation.dart';

class LoginBloc {
  StreamController _usercontroller = new StreamController.broadcast();
  StreamController _passcontroller = new StreamController.broadcast();
  Stream get userStream => _usercontroller.stream;
  Stream get passStream => _passcontroller.stream;

  bool isValidInfo(String user, String pass) {
    bool status = true;
    if (!Validation.isValidUser(user)) {
      status = false;
      _usercontroller.sink
          .addError(allTranslations.text("username_invalid").toString());
    }
    if (Validation.isValidUser(user)) {
      status = true;
      _usercontroller.sink.add("OK");
    }

    if (!Validation.isValidPass(pass)) {
      status = false;
      _passcontroller.sink
          .addError(allTranslations.text("password_invalid").toString());
    }
    if (Validation.isValidPass(pass)) {
      status = true;
      _passcontroller.sink.add("OK");
    }
    return status;
  }

  void dispose() {
    _passcontroller.close();
    _usercontroller.close();
  }
}
