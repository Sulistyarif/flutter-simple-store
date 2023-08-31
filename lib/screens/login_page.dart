import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_store/screens/product_list_page.dart';
import 'package:simple_store/utlis/styles.dart';

import '../api/client_api.dart';
import '../controller/user_controller.dart';
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
  bool isRememberMe = false;
  final userController = Get.find<UserController>();

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Sign In',
                  textAlign: TextAlign.center,
                  // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  style: GoogleFonts.lexendDeca(
                    fontSize: 36,
                    fontWeight: FontWeight.w500,
                    color: Styles.primaryColor,
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: controllerUsername,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Styles.textfieldBorder),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Styles.textfieldBorder),
                    ),
                    contentPadding: EdgeInsets.only(left: 15),
                    filled: true,
                    hintStyle: GoogleFonts.lexendDeca(
                      fontSize: 15,
                      color: Colors.black.withOpacity(0.25),
                    ),
                    hintText: "  Username",
                    fillColor: Colors.white70,
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: controllerPassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Styles.textfieldBorder),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Styles.textfieldBorder),
                    ),
                    contentPadding: EdgeInsets.only(left: 15),
                    filled: true,
                    hintStyle: GoogleFonts.lexendDeca(
                      fontSize: 15,
                      color: Colors.black.withOpacity(0.25),
                    ),
                    hintText: "  Password",
                    fillColor: Colors.white70,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Checkbox(
                      value: isRememberMe,
                      onChanged: (value) {
                        setState(() {
                          isRememberMe = !isRememberMe;
                        });
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7),
                      ),
                      side: MaterialStateBorderSide.resolveWith(
                        (states) =>
                            BorderSide(width: 1.0, color: Color(0xFFD9D9D9)),
                      ),
                    ),
                    Text(
                      'Remember Me',
                      style: TextStyle(color: Colors.grey[800]),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          _onForgotTapped();
                        },
                        child: Text(
                          'Forgot Password',
                          textAlign: TextAlign.right,
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Styles.btLogin,
                  ),
                  onPressed: () {
                    _onLoginTapped();
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'or',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.black.withOpacity(0.2),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        'Sign in With',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.black.withOpacity(0.2),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 30),
                loginWithGoogle(),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: RichText(
                  text: TextSpan(
                      text: 'Don\'t have account?',
                      style: TextStyle(
                        color: Colors.grey[800],
                      ),
                      children: [
                        TextSpan(
                          text: ' Sign Up Here!',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onLoginTapped() async {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: const [
                CircularProgressIndicator(),
                SizedBox(width: 20),
                Text(
                  'Loading',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ],
            ),
          ),
        );
      },
    );
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

  Widget loginWithGoogle() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          userController.loginWithGoogle(context);
        },
        style: OutlinedButton.styleFrom(
          shape: StadiumBorder(),
          backgroundColor: Colors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/google-logo.png',
              height: 20,
              width: 20,
            ),
            const SizedBox(width: 10),
            const Text(
              'Login with google',
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
