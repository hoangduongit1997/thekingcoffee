import 'dart:async';

import 'package:thekingcoffee/app/validation/validation.dart';

class ResetPassBloc {
  StreamController _passcontroller = new StreamController();
  StreamController _confirmcontroller = new StreamController();
  Stream get passStream => _passcontroller.stream;
  Stream get confirmStream => _confirmcontroller.stream;

  bool isValidInfo(String pass, String confirm) {
    bool status = true;
    if (!Validation.isValidPass(pass)) {
      status = false;
      _passcontroller.sink.addError("Pass invalide");
    }
    if (Validation.isValidPass(pass)) {
      status = true;
      _passcontroller.sink.add("OK");
    }
    if (!Validation.isValidConfirmPass(pass, confirm)) {
      status = false;
      _confirmcontroller.sink.addError("Confirm invalid");
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
