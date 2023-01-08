import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_store/screens/product_list_page.dart';

import '../api/client_api.dart';
import '../utlis/utils.dart';
import '../widget/dialog_forgot.dart';
import '../widget/dialog_register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: controllerUsername,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: "Username",
                  fillColor: Colors.white70),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: controllerPassword,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                hintStyle: TextStyle(color: Colors.grey[800]),
                hintText: "Password",
                fillColor: Colors.white70,
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
                onPressed: () {
                  _onLoginTapped();
                },
                child: const Text('Login')),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                _onRegisterTapped();
              },
              child: const Text(
                'Dont have account? Create a new one.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                _onForgotTapped();
              },
              child: const Text(
                'Forgot Password',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onLoginTapped() async {
    final loginRes = await ClientApi.login(
        controllerUsername.text, controllerPassword.text, context);
    if (loginRes['success']) {
      moveNextPage();
    } else {
      showSnackBar(loginRes['message']);
    }
  }

  void _onRegisterTapped() {
    showDialog(
      context: context,
      builder: (context) {
        return const DialogRegister();
      },
    );
  }

  void _onForgotTapped() {
    showDialog(
      context: context,
      builder: (context) {
        return const DialogForgot();
      },
    );
  }

  void moveNextPage() {
    Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(
          builder: (context) => const ProductListPage(),
        ),
        (Route<dynamic> route) => false);
  }

  void showSnackBar(String message) {
    Utils.showSnackBar(context, message);
  }
}
