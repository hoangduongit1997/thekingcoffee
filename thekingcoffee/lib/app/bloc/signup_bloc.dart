import 'dart:async';
import 'package:thekingcoffee/app/validation/validation.dart';
import 'package:thekingcoffee/core/components/lib/change_language/change_language.dart';

class SignupBloc {
  StreamController _accpetcontroller = new StreamController.broadcast();
  StreamController _usernamecontroller = new StreamController.broadcast();
  StreamController _phonecontroller = new StreamController.broadcast();
  StreamController _passcontroller = new StreamController.broadcast();
  StreamController _confirmpasscontroller = new StreamController.broadcast();
  StreamController _datecontroller = new StreamController.broadcast();
  StreamController _fullnamecontroler = new StreamController.broadcast();
  StreamController _gmailcontroler = new StreamController.broadcast();
  Stream get usernameStream => _usernamecontroller.stream;
  Stream get phoneStream => _phonecontroller.stream;
  Stream get passStream => _passcontroller.stream;
  Stream get confirmStream => _confirmpasscontroller.stream;
  Stream get dateStream => _datecontroller.stream;
  Stream get acceptStream => _accpetcontroller.stream;
  Stream get fullnameStream => _fullnamecontroler.stream;
  Stream get gmailStream => _gmailcontroler.stream;
  bool isValidInfo(String name, String phone, String pass, String confirm,
      String date, bool checked, String fullname, String gmail) {
    bool status = true;
    if (!Validation.isValidUser(name)) {
      status = false;
      _usernamecontroller.sink
          .addError(allTranslations.text("username_invalid").toString());
    }
    if (Validation.isValidUser(name)) {
      status = true;
      _usernamecontroller.sink.add("OK");
    }
    if (Validation.isValidUser(fullname)) {
      status = true;
      _fullnamecontroler.sink.add("OK");
    }
    if (!Validation.isValidUser(fullname)) {
      status = false;
      _fullnamecontroler.sink
          .addError(allTranslations.text("full_name_invalid").toString());
    }
    if (!Validation.isValidPhoneNumber(phone)) {
      status = false;
      _phonecontroller.sink
          .addError(allTranslations.text("invalid_phone_number").toString());
    }
    if (Validation.isValidPhoneNumber(phone)) {
      status = true;
      _phonecontroller.sink.add("OK");
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

    if (!Validation.isValidConfirmPass(pass, confirm)) {
      status = false;
      _confirmpasscontroller.sink
          .addError(allTranslations.text("confirm_password").toString());
    }
    if (Validation.isValidConfirmPass(pass, confirm)) {
      status = true;
      _confirmpasscontroller.sink.add("OK");
    }

    if (!Validation.isValidDate(date)) {
      status = false;
      _datecontroller.sink
          .addError(allTranslations.text("date_invalid").toString());
    }
    if (Validation.isValidDate(date)) {
      status = true;
      _datecontroller.sink.add("OK");
    }

    if (!Validation.isValidAccept(checked)) {
      status = false;
      _accpetcontroller.sink
          .addError(allTranslations.text("unckeck").toString());
    }
    if (Validation.isValidAccept(checked)) {
      status = true;
      _accpetcontroller.sink.add("OK");
    }
    if (!Validation.isValidGmail(gmail)) {
      status = false;
      _gmailcontroler.sink
          .addError(allTranslations.text("gmail_invalid").toString());
    }
    if (Validation.isValidGmail(gmail)) {
      status = true;
      _gmailcontroler.sink.add("OK");
    }
    return status;
  }

  void dispose() {
    _confirmpasscontroller.close();
    _datecontroller.close();
    _usernamecontroller.close();
    _passcontroller.close();
    _phonecontroller.close();
    _accpetcontroller.close();
    _fullnamecontroler.close();
    _gmailcontroler.close();
  }
}
