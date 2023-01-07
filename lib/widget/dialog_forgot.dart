import 'package:flutter/material.dart';

import '../api/client_api.dart';

class DialogForgot extends StatefulWidget {
  const DialogForgot({super.key});

  @override
  State<DialogForgot> createState() => _DialogForgotState();
}

class _DialogForgotState extends State<DialogForgot> {
  TextEditingController controllerUsername = TextEditingController();
  String? message = '';

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
              'Forgot password',
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
            ElevatedButton(
              onPressed: () async {
                message = await ClientApi.forgot(controllerUsername.text);
                setState(() {});
              },
              child: const Text('Forgot Password'),
            ),
            SizedBox(
              child: message!.isNotEmpty
                  ? Text(
                      message!,
                      textAlign: TextAlign.center,
                    )
                  : const SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
