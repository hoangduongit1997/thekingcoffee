import 'dart:async';

import 'package:thekingcoffee/app/validation/validation.dart';

class GmailAuthBloc {
  StreamController _gmailcontroller = new StreamController();
  Stream get gmailStream => _gmailcontroller.stream;
  
  bool isValidInfo(String gmail) {
    bool status = true;
    if (!Validation.isValidGmail(gmail)) {
      status = false;
      _gmailcontroller.sink.addError("Gmail invalide");
    }
    if (Validation.isValidGmail(gmail)) {
      status = true;
      _gmailcontroller.sink.add("OK");
    }
    return status;
  }

  void dispose() {
    _gmailcontroller.close();
  }
}
