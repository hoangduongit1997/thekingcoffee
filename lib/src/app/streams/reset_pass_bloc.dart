import 'dart:async';
import 'package:thekingcoffee/src/app/core/components/lib/change_language/change_language.dart';
import 'package:thekingcoffee/src/app/core/validation.dart';

class ResetPassBloc {
  StreamController _passcontroller = new StreamController();
  StreamController _confirmcontroller = new StreamController();
  Stream get passStream => _passcontroller.stream;
  Stream get confirmStream => _confirmcontroller.stream;

  bool isValidInfo(String pass, String confirm) {
    bool status = true;
    if (!Validation.isValidPass(pass)) {
      status = false;
      _passcontroller.sink
          .addError(allTranslations.text("password_invalid").toString());
    }
    if (Validation.isValidPass(pass)) {
      status = true;
      _passcontroller.sink.add("OK");
    }
    if (!Validation.isValidConfirmPass(pass, confirm)) {
      status = false;
      _confirmcontroller.sink
          .addError(allTranslations.text("confirm_password").toString());
    }
    if (Validation.isValidConfirmPass(pass, confirm)) {
      status = true;
      _confirmcontroller.sink.add("OK");
    }
    return status;
  }

  void dispose() {
    _passcontroller.close();
    _confirmcontroller.close();
  }
}
