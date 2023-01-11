import 'package:flutter/material.dart';
import 'package:simple_store/widget/custom_rounded_button.dart';

class DialogYesNo extends StatelessWidget {
  final Function() onYes;
  final String title;
  const DialogYesNo({super.key, required this.onYes, required this.title});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: CustomRoundedButton(
                      onTap: () {
                        onYes();
                      },
                      buttonTitle: 'Yes'),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomRoundedButton(
                      warna: Colors.red,
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      buttonTitle: 'No'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
