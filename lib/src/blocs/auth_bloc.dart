import 'dart:async';

import 'package:flutter_taxiapp/src/fire_base/fire_base_auth.dart';

class AuthBloc {
  var _firAuth = FirAuth();
  StreamController _nameController = new StreamController();
  StreamController _phoneController = new StreamController();
  StreamController _emailController = new StreamController();
  StreamController _passController = new StreamController();

  Stream get nameStream => _nameController.stream;

  Stream get phoneStream => _phoneController.stream;

  Stream get emailStream => _emailController.stream;

  Stream get passStream => _passController.stream;

  bool isValid(String name, String phone, String email, String pass) {
    if (name == null || name.length == 0) {
      _nameController.sink.addError("Input name");
      return false;
    }
    _nameController.sink.add("");

    if (phone == null || phone.length == 0) {
      _phoneController.sink.addError("Input phone number");
      return false;
    }
    _phoneController.sink.add("");

    if (email == null || email.length == 0) {
      _emailController.sink.addError("Input email");
      return false;
    }
    _emailController.sink.add("");

    if (pass == null || pass.length == 0) {
      _passController.sink.addError("Input password");
      return false;
    }
    _passController.sink.add("");

    return true;
  }

  void signUp(String email, String pass, String name, String phone,
      Function onSuccess) {
    _firAuth.signUp(email, pass, name, phone, onSuccess);
  }

  void dispose() {
    _nameController.close();
    _phoneController.close();
    _emailController.close();
    _passController.close();
  }
}
