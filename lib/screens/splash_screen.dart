import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Align(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  width: 43,
                  height: 109,
                  'assets/images/simplestorelogo.png',
                ),
                const SizedBox(width: 10),
                Text(
                  'Simple\nStore',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.lexendDeca(
                    fontSize: 36,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
