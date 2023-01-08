import 'package:flutter/material.dart';

class Utils {
  static void showSnackBar(context, String message) {
    var snackBar = SnackBar(
      content: Text('Login failed. $message'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
