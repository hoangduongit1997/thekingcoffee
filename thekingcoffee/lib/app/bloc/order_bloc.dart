import 'dart:async';

import 'package:thekingcoffee/app/validation/validation.dart';

class OrderBloc {
  StreamController _namecontroller = new StreamController.broadcast();
  StreamController _phonecontroller = new StreamController.broadcast();
  StreamController _addresscontroller = new StreamController.broadcast();
  Stream get nameStream => _namecontroller.stream;
  Stream get phoneStream => _phonecontroller.stream;
  Stream get addressStream => _addresscontroller.stream;

  bool isValidInfo(String name, String phone, String address) {
    bool status = true;
    if (!Validation.isValidUser(name)) {
      status = false;
      _namecontroller.sink.addError("Name invalid");
    }
    if (Validation.isValidUser(name)) {
      status = true;
      _namecontroller.sink.add("OK");
    }
    if (!Validation.isValidPhoneNumber(phone)) {
      status = false;
      _phonecontroller.sink.addError("Phone invalid");
    }
    if (Validation.isValidPhoneNumber(phone)) {
      status = true;
      _phonecontroller.sink.add("OK");
    }
    if (!Validation.isValidAddress(address)) {
      status = false;
      _addresscontroller.sink.addError("Address invalid");
    }
    if (Validation.isValidAddress(address)) {
      status = true;
      _addresscontroller.sink.add("OK");
    }
    return status;
  }

  void dispose() {
    _namecontroller.close();
    _addresscontroller.close();
    _phonecontroller.close();
  }
}
