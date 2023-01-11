import 'package:flutter/material.dart';

class CustomRoundedButton extends StatelessWidget {
  final Function()? onTap;
  final Color? warna;
  final String? buttonTitle;
  const CustomRoundedButton(
      {Key? key, required this.onTap, this.warna, required this.buttonTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(warna != null ? warna : Colors.blue),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
      child: Text(
        buttonTitle!,
        textAlign: TextAlign.center,
        // style: TextStyle(fontSize: 12),
      ),
      onPressed: () {
        onTap!();
      },
    );
  }
}
