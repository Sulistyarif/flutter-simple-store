import 'package:flutter/material.dart';

import 'screens/login_page.dart';

void main() {
  // runApp(const TestGlintsAlfariski());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
