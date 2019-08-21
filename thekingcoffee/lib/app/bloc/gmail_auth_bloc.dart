import 'dart:async';

import 'package:thekingcoffee/app/validation/validation.dart';
import 'package:thekingcoffee/core/components/lib/change_language/change_language.dart';

class GmailAuthBloc {
  StreamController _gmailcontroller = new StreamController();
  Stream get gmailStream => _gmailcontroller.stream;

  bool isValidInfo(String gmail) {
    bool status = true;
    if (!Validation.isValidGmail(gmail)) {
      status = false;
      _gmailcontroller.sink
          .addError(allTranslations.text("gmail_invalid").toString());
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
