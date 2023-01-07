import 'package:flutter/material.dart';
import 'package:simple_store/models/users.dart';

class ProviderUser extends ChangeNotifier {
  Users? user;

  void setUser(Users param) {
    user = param;
    notifyListeners();
  }

  bool getStatusLogin() {
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }
}
