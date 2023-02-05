import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';

class Utils {
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

  static void showSnackBar(context, String message) {
    var snackBar = SnackBar(
      content: Text('Login failed. $message'),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static String formatDecimal(int number) {
    if (number > -1000 && number < 1000) return number.toString();

    final String digits = number.abs().toString();
    final StringBuffer result = StringBuffer(number < 0 ? '-' : '');
    final int maxDigitIndex = digits.length - 1;
    for (int i = 0; i <= maxDigitIndex; i += 1) {
      result.write(digits[i]);
      if (i < maxDigitIndex && (maxDigitIndex - i) % 3 == 0) result.write('.');
    }
    return result.toString();
  }

  static String getRandomString(int length, rnd) =>
      String.fromCharCodes(Iterable.generate(
          length, (_) => _chars.codeUnitAt(rnd.nextInt(_chars.length))));

  static void trackScreen(String screenName, String screenClass) async {
    await FirebaseAnalytics.instance.logEvent(
      name: 'screen_view',
      parameters: {
        'firebasescreen': screenName,
        'firebasescreenclass': screenClass,
      },
    );
  }
}
