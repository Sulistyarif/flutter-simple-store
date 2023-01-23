import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api/client_api.dart';

class DialogRegister extends StatefulWidget {
  const DialogRegister({super.key});

  @override
  State<DialogRegister> createState() => _DialogRegisterState();
}

class _DialogRegisterState extends State<DialogRegister> {
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Create new user',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(height: 10),
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
              controller: controllerEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  hintStyle: TextStyle(color: Colors.grey[800]),
                  hintText: "Email",
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
                  fillColor: Colors.white70),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                bool res = await ClientApi.register(controllerUsername.text,
                    controllerEmail.text, controllerPassword.text);
                if (res) {
                  Get.back();
                }
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
