import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:simple_store/data/provider_user.dart';
import 'package:simple_store/models/users.dart';

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
    return Scaffold(body: Obx(
      () {
        return SizedBox(
          child: userController.isLoggedIn.value
              ? contentLoggedIn()
              : contentLoggedOut(),
        );
      },
    ));
  }

  Widget contentLoggedOut() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          userController.loginWithGoogle();
        },
        child: const Text('Login with google'),
      ),
    );
  }

  Widget contentLoggedIn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        userController.auth.currentUser!.photoURL != null
            ? Image.network(
                userController.auth.currentUser!.photoURL!,
                width: 75,
                height: 75,
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
        )
      ],
    );
  }
}
