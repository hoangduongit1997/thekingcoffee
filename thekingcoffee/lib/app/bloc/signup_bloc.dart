import 'dart:async';
import 'package:thekingcoffee/app/validation/validation.dart';

class SignupBloc {
  StreamController _accpetcontroller = new StreamController();
  StreamController _usernamecontroller = new StreamController();
  StreamController _phonecontroller = new StreamController();
  StreamController _passcontroller = new StreamController();
  StreamController _confirmpasscontroller = new StreamController();
  StreamController _datecontroller = new StreamController();
  StreamController _fullnamecontroler = new StreamController();
  Stream get usernameStream => _usernamecontroller.stream;
  Stream get phoneStream => _phonecontroller.stream;
  Stream get passStream => _passcontroller.stream;
  Stream get confirmStream => _confirmpasscontroller.stream;
  Stream get dateStream => _datecontroller.stream;
  Stream get acceptStream => _accpetcontroller.stream;
  Stream get fullnameStream => _fullnamecontroler.stream;
  bool isValidInfo(String name, String phone, String pass, String confirm,
      String date, bool checked, String fullname) {
    bool status = true;
    if (!Validation.isValidUser(name)) {
      status = false;
      _usernamecontroller.sink.addError("Name invalid");
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
      _fullnamecontroler.sink.addError("Fullname invalid");
    }
    if (!Validation.isValidPhoneNumber(phone)) {
      status = false;
      _phonecontroller.sink.addError("Phone number invalid");
    }
    if (Validation.isValidPhoneNumber(phone)) {
      status = true;
      _phonecontroller.sink.add("OK");
    }

    if (!Validation.isValidPass(pass)) {
      status = false;
      _passcontroller.sink.addError("Password invalid");
    }
    if (Validation.isValidPass(pass)) {
      status = true;
      _passcontroller.sink.add("OK");
    }

    if (!Validation.isValidConfirmPass(pass, confirm)) {
      status = false;
      _confirmpasscontroller.sink.addError("Confirm password invalid");
    }
    if (Validation.isValidConfirmPass(pass, confirm)) {
      status = true;
      _confirmpasscontroller.sink.add("OK");
    }

    if (!Validation.isValidDate(date)) {
      status = false;
      _datecontroller.sink.addError("Date invalid");
    }
    if (Validation.isValidDate(date)) {
      status = true;
      _datecontroller.sink.add("OK");
    }

    if (!Validation.isValidAccept(checked)) {
      status = false;
      _accpetcontroller.sink.addError("Unchecked");
    }
    if (Validation.isValidAccept(checked)) {
      status = true;
      _accpetcontroller.sink.add("OK");
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
  }
}
