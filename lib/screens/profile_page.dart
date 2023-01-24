import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/user_controller.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Obx(
        () {
          return SizedBox(
            child: userController.isLoggedIn.value
                ? contentLoggedIn()
                : contentLoggedOut(),
          );
        },
      ),
    );
  }

  Widget contentLoggedOut() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          userController.loginWithGoogle(context);
        },
        style: OutlinedButton.styleFrom(
          shape: StadiumBorder(),
          backgroundColor: Colors.white,
        ),
        // style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
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

  Widget contentLoggedIn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        userController.auth.currentUser!.photoURL != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network(
                      userController.auth.currentUser!.photoURL!,
                      width: 75,
                      height: 75,
                    ),
                  ),
                ],
              )
            : const Icon(Icons.person),
        const SizedBox(height: 10),
        const Text(
          'Name',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          userController.auth.currentUser!.displayName!,
          textAlign: TextAlign.center,
          style: const TextStyle(),
        ),
        const SizedBox(height: 10),
        const Text(
          'Email',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          userController.auth.currentUser!.email!,
          textAlign: TextAlign.center,
          style: const TextStyle(),
        ),
        const SizedBox(height: 10),
        const Text(
          'UID',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          userController.auth.currentUser!.uid,
          textAlign: TextAlign.center,
          style: const TextStyle(),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 4),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              userController.logoutGoogle();
            },
            child: const Text('Logout'),
          ),
        ),
      ],
    );
  }
}
