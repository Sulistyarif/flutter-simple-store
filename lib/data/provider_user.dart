import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:simple_store/models/users.dart';

class ProviderUser extends ChangeNotifier {
  Users? user;

  void setUser(Users param) {
    user = param;
    final storage = GetStorage();
    storage.write('id', param.id);
    storage.write('email', param.email);
    storage.write('username', param.username);
    notifyListeners();
  }

  bool getStatusLogin() {
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  void doLogout() {
    user = null;
    notifyListeners();
  }
}
